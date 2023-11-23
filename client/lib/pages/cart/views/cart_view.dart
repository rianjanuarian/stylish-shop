import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../../../services/api_service/cart/cart_models.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onTap: () => controller.goToSearch(),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: REdgeInsets.symmetric(horizontal: 30.0),
                    child: Icon(Icons.search, size: 32.sp),
                  ),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                  fillColor: const Color(0xffF3F4F5),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30).r,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text('My Cart',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              SizedBox(height: 20.h),
              FutureBuilder(
                  future: controller.getCart(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (controller.carts.isEmpty) {
                      return Lottie.asset('assets/animations/empty.json');
                    }
                    return Column(
                      children: controller.carts.map(
                        (cart) {
                          return CartItem(
                            keyItem: cart.id,
                            title: cart.product.name,
                            image: cart.product.image,
                            description: cart.product.description,
                            price: cart.total_price,
                            quantity: cart.qty,
                            variant: cart.color,
                          );
                        },
                      ).toList(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.keyItem,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity, 
    required this.variant,
 });
  final int keyItem;
  final String image;
  final String title;
  final String description;
  final int price;
  final int quantity;
  final String variant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 20),
      child: Slidable(
        key: ValueKey(keyItem),
        endActionPane: ActionPane(
            dragDismissible: false,
            extentRatio: 0.3,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (ctx) {
                  Get.defaultDialog(
                    title: 'Confirmation',
                    middleText: 'Are you sure you want to delete this item?',
                    textConfirm: 'Delete',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    onCancel: () => Get.back(),
                    onConfirm: () {
                      Get.back();
                    },
                  );
                },
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(13).r,
                    bottomRight: const Radius.circular(13).r),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
        child: Container(
          width: double.infinity,
          height: 100.h,
          padding: REdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13).r,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10).r,
                    child: CachedNetworkImage(
                      imageUrl: (image).contains('placeholder')
                          ? "https://via.placeholder.com/200"
                          : 'https://storage.googleapis.com/$image',
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14.sp),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                                color: const Color(0xff666666),
                                fontSize: 11.sp),
                          ),
                          Text(
                            'variant: $variant',
                            style: TextStyle(
                                color: const Color(0xff666666),
                                fontSize: 10.sp),
                          ),
                        ],
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(price),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 30.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(30).r,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          //substract the quantity
                        },
                        child: const Icon(Icons.remove, size: 16),
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          //add the quantity
                        },
                        child: const Icon(Icons.add, size: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
