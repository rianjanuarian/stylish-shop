import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../../../services/api_service/cart/cart_models.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: () => controller.getCart(),
        showChildOpacityTransition: false,
        borderWidth: 2,
        backgroundColor: Colors.black,
        springAnimationDurationInMilliseconds: 200,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.sp)),
                SizedBox(height: 20.h),
                FutureBuilder(
                  future: controller.getCart(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 0.70.sh,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Obx(
                      () {
                        if (controller.carts.isNotEmpty) {
                          return Column(
                            children: controller.carts.map(
                              (cart) {
                                return CartItem(
                                  cart: cart,
                                  controller: controller,
                                );
                              },
                            ).toList(),
                          );
                        } else {
                          return Column(
                            children: [
                              Lottie.asset('assets/animations/empty.json'),
                              const Text(
                                  'Nothing inside cart, try adding some!')
                            ],
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cart,
    required this.controller,
  });
  final Cart cart;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 20),
      child: Slidable(
        key: ValueKey(cart.id),
        endActionPane: ActionPane(
            dragDismissible: false,
            extentRatio: 0.3,
            motion: const ScrollMotion(),
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
                    onConfirm: () async {
                      controller.removeCart(cart.id ?? 0);
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
                      imageUrl: (cart.product?.image ??
                                  "https://via.placeholder.com/200")
                              .contains('placeholder')
                          ? "https://via.placeholder.com/200"
                          : 'https://storage.googleapis.com/${cart.product?.image}',
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
                            cart.product?.name ?? 'No Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14.sp),
                          ),
                          Text(
                            cart.product?.description ?? 'No Description',
                            style: TextStyle(
                                color: const Color(0xff666666),
                                fontSize: 11.sp),
                          ),
                          Text(
                            'variant: ${cart.color}',
                            style: TextStyle(
                                color: const Color(0xff666666),
                                fontSize: 10.sp),
                          ),
                        ],
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(cart.total_price),
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
                        onTap: () => (cart.qty ?? 0) > 1
                            ? controller.substractQuantity(cart.id ?? 0)
                            : null,
                        child: const Icon(Icons.remove, size: 16),
                      ),
                    ),
                    Text(
                      '${cart.qty ?? 0}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () =>
                            (cart.qty ?? 0) < (cart.product?.stock ?? 0)
                                ? controller.addQuantity(cart.id ?? 0)
                                : null,
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
