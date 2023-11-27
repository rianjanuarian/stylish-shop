import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/pages/cart/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../services/api_service/courier/courier_models.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../profile/setting/controllers/setting_controller.dart';
import '../controllers/place_order_controller.dart';

class PlaceOrderView extends GetView<PlaceOrderView> {
  const PlaceOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlaceOrderController());
    final userController = Get.put(SettingController());
    final cartController = Get.put(CartController());

    // final List order = [
    //   {
    //     'image':
    //         'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    //     'title': 'Roller Rabbit',
    //     'description': 'Vado Odelle Dress',
    //     'price': 198,
    //     'quantity': 1,
    //   },
    //   {
    //     'image':
    //         'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    //     'title': 'Axel Arigato',
    //     'description': 'Clean 90 Triole Snakers',
    //     'price': 245,
    //     'quantity': 1,
    //   },
    // ];
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70.h,
        padding: REdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, -4))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(cartController.totalPrice),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.white),
              child: const Text('Place Order'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leadingWidth: 80.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          style: IconButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              userController.user.value?.address == null
                  ? Container(
                      padding: REdgeInsets.all(10),
                      width: double.infinity,
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).r,
                        color: const Color(0xFFD9D9D9),
                      ),
                      child: const Text(
                        "Please update your address in profile page...",
                      ),
                    )
                  : Container(
                      padding: REdgeInsets.all(10),
                      width: double.infinity,
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).r,
                        color: const Color(0xFFD9D9D9),
                      ),
                      child: Text(
                        '${userController.user.value?.address}',
                      ),
                    ),
              SizedBox(height: 20.h),
              Text(
                'Product Item',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (cartController.isLoading.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: cartController.carts.map((cart) {
                      return CartItem(
                        cart: cart,
                        controller: cartController,
                      );
                    }).toList(),
                  );
                }
              }),
              Text(
                'Courier',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.isLoading.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return _Courier(controller: controller);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}


class _Courier extends StatelessWidget {
  const _Courier({required this.controller});

  final PlaceOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final Courier courier = controller.selectedCourier.value ?? Courier();

      return GestureDetector(
        onTap: () {
          _showDropdown(context);
        },
        child: Container(
          height: 70.h,
          padding: REdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(30).r,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://storage.googleapis.com/${courier.image}',
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${courier.name}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(courier.price),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20).r,
                child: InkWell(
                  onTap: () {
                    _showDropdown(context);
                  },
                  borderRadius: BorderRadius.circular(20).r,
                  child: const Icon(Icons.expand_more),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Courier'),
          content: SizedBox(
            width: 200,
            child: DropdownButton<Courier>(
              value: controller.selectedCourier.value,
              onChanged: (Courier? newValue) {
                controller.setSelectedCourier(newValue);
                Navigator.of(context).pop();
              },
              items: controller.couriers.map((Courier courier) {
                return DropdownMenuItem<Courier>(
                  value: courier,
                  child: Text(courier.name!),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}