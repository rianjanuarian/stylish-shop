import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../services/api_service/cart/cart_models.dart';
import '../../../services/api_service/courier/courier_models.dart';
import '../../profile/setting/controllers/setting_controller.dart';
import '../controllers/place_order_controller.dart';

class PlaceOrderView extends GetView<PlaceOrderController> {
  const PlaceOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    void showDropdown(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            title: const Text('Select your Courier'),
            content: SizedBox(
              width: 200.w,
              child: DropdownButton<Courier>(
                isExpanded: true,
                value: controller.selectedCourier.value,
                onChanged: (Courier? newValue) {
                  controller.setSelectedCourier(newValue);
                  Navigator.of(context).pop();
                },
                items: controller.couriers.map((Courier courier) {
                  return DropdownMenuItem<Courier>(
                    value: courier,
                    child: Text(courier.name ?? 'No Courier Selected'),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );
    }

    Widget unremovableBasket(Cart cart) {
      return Padding(
        padding: REdgeInsets.only(bottom: 20),
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
                            limitWord(
                                cart.product?.description ?? 'No Description'),
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
              Padding(
                padding: REdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Qty: ', style: TextStyle(fontSize: 12.sp)),
                    Text(
                      '${cart.qty ?? 0}',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget courierContainer(controller) {
      return Obx(() {
        final Courier courier = controller.selectedCourier.value ?? Courier();
        return GestureDetector(
          onTap: () => showDropdown(context),
          child: Container(
            height: 70.h,
            padding: REdgeInsets.symmetric(horizontal: 10),
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
              children: [
                courier.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20).r,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://storage.googleapis.com/${courier.image}',
                          width: 70.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : Container(),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courier.name ?? 'No Courier Selected',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(courier.price ?? 0),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    }

    final userController = Get.put(SettingController());
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
                Obx(
                  () => Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(controller.totalPrice.value),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                ),
              ],
            ),
            Obx(
              () => ElevatedButton(
                onPressed: controller.selectedCourier.value == null
                    ? null
                    : () => controller.placeOrder(),
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor:
                      controller.selectedCourier.value == null
                          ? Colors.grey.shade200
                          : null,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Place Order'),
              ),
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
              Container(
                padding: REdgeInsets.all(10),
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10).r,
                  color: const Color(0xFFD9D9D9),
                ),
                child: Text(
                  userController.user.value?.address == null
                      ? "Please update your address in profile page..."
                      : '${userController.user.value?.address}',
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Product Item',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              Column(
                children: controller.carts.map((cart) {
                  return unremovableBasket(cart);
                }).toList(),
              ),
              Text(
                'Courier',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.isLoading.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return courierContainer(controller);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

String limitWord(String text) {
  List<String> words = text.split(' ');

  if (words.length <= 3) {
    return text;
  } else {
    return '${words.take(3).join(' ')}...';
  }
}
