import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/order_ongoing_controller.dart';

class OrderOngoingView extends GetView<OrderOngoingController> {
  const OrderOngoingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              'My Order',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32.sp),
            ),
            SizedBox(height: 20.h),
            Container(
              height: 60.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFf0f0f0),
                  borderRadius: BorderRadius.circular(10).r),
              child: Obx(
                () => Padding(
                  padding: REdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => controller.switchTo(true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: controller.isOngoing.isTrue
                                ? Colors.black
                                : null,
                            borderRadius: BorderRadius.circular(7).r,
                          ),
                          width: 165.w,
                          height: 40.h,
                          child: Center(
                            child: Text(
                              'Ongoing',
                              style: TextStyle(
                                color: controller.isOngoing.isTrue
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.switchTo(false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: controller.isOngoing.isFalse
                                ? Colors.black
                                : null,
                            borderRadius: BorderRadius.circular(7).r,
                          ),
                          width: 165.w,
                          height: 40.h,
                          child: Center(
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                color: controller.isOngoing.isFalse
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Obx( () => Column(
                    children: controller.isOngoing.isTrue
                        ? controller.orderOnGoing
                            .map((order) => _OrderWidget(
                                  title: order['title'],
                                  description: order['description'],
                                  image: order['image'],
                                  price: order['price'],
                                ))
                            .toList()
                        : controller.orderCompleted
                            .map((order) => _OrderWidget(
                                  title: order['title'],
                                  description: order['description'],
                                  image: order['image'],
                                  price: order['price'],
                                ))
                            .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderWidget extends StatelessWidget {
  const _OrderWidget(
      {required this.image,
      required this.title,
      required this.description,
      required this.price});
  final String image;
  final String title;
  final String description;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 1.sw,
      margin: REdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10).r,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 5.0, offset: Offset(2, 3))
          ]),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5).r,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: 80.w,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF8E8E8E)),
                    )
                  ],
                ),
              ],
            ),
            Text(
              '\$$price.00',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
