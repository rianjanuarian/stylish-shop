import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../services/api_service/transaction/transaction_model.dart';
import '../../../../widgets/app_shimmer.dart';
import '../controllers/order_ongoing_controller.dart';

class OrderOngoingView extends GetView<OrderOngoingController> {
  const OrderOngoingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String getStatusString(Status? status) {
      if (status == Status.approve) {
        return 'approve';
      } else if (status == Status.pending) {
        return 'pending';
      } else if (status == Status.reject) {
        return 'reject';
      } else {
        return 'unknown';
      }
    }

    Widget orderWidget(
        {int id = 0,
        String orderId = "no order id",
        String courierName = 'no courier name',
        String midtransToken = 'no midtrans token',
        String status = ''}) {
      return Container(
        height: 100.h,
        width: 1.sw,
        margin: REdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5.0, offset: Offset(2, 3))
            ]),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10).r,
          child: InkWell(
            borderRadius: BorderRadius.circular(10).r,
            onTap: status == 'approve'
                ? null
                : () => controller.goToPayment(midtransToken),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        minRadius: 20.r,
                        child: Text(id.toString()),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderId,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            courierName,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF8E8E8E)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    status,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget cardCart() {
      return Card(
        margin: REdgeInsets.only(bottom: 20),
        child: Container(
            height: 70.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10).r,
            )),
      );
    }

    Widget shimmerCardCart() {
      return AppShimmer(
        child: Column(
          children: List.generate(5, (index) => cardCart()),
        ),
      );
    }

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
                child: Obx(
                  () {
                    if (controller.isLoading.isTrue) {
                      return shimmerCardCart();
                    }
                    if (controller.isOngoing.isTrue) {
                      return controller.onGoing.isEmpty
                          ? Column(
                              children: [
                                Lottie.asset('assets/animations/empty.json',
                                    height: 300.h, width: double.infinity),
                                const Text('Try Purchasing something!')
                              ],
                            )
                          : Column(
                              children: controller.onGoing
                                  .map((order) => orderWidget(
                                      id: order.id ?? 0,
                                      orderId: order.orderId ?? 'no order id',
                                      courierName:
                                          order.courier?.name ?? 'courier',
                                      status: getStatusString(order.status),
                                      midtransToken: order.midtranstoken ??
                                          'no midtranstoken'))
                                  .toList(),
                            );
                    } else {
                      return controller.onCompleted.isEmpty
                          ? Column(
                              children: [
                                Lottie.asset('assets/animations/empty.json',
                                    height: 300.h, width: double.infinity),
                                const Text('Try Purchasing something!')
                              ],
                            )
                          : Column(
                              children: controller.onCompleted
                                  .map(
                                    (order) => orderWidget(
                                        id: order.id ?? 0,
                                        orderId: order.orderId ?? 'no order id',
                                        courierName:
                                            order.courier?.name ?? 'courier',
                                        status: getStatusString(order.status),
                                        midtransToken: order.midtranstoken ??
                                            'no midtranstoken'),
                                  )
                                  .toList(),
                            );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
