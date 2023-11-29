import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/new_arrival_controller.dart';

class NewArrivalView extends GetView<NewArrivalController> {
  const NewArrivalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String pages = Get.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.only(top: 15, right: 10, left: 10),
          child: FutureBuilder(
            future: controller.getProduct(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        style:
                            IconButton.styleFrom(backgroundColor: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        color: Colors.white,
                        style: IconButton.styleFrom(
                            iconSize: 40.sp,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: REdgeInsets.only(left: 8.0, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pages,
                          style: TextStyle(
                              fontSize: 28.sp, fontWeight: FontWeight.w700),
                        ),
                        Obx(
                          () => controller.isLoading.value
                              ? shimmerArrival()
                              : GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 50,
                                  ),
                                  itemCount: controller.productList.length,
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: () => controller.goToDetail(
                                          controller.productList[index]),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10).r),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      219, 219, 219, 100),
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                          .r),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15).r,
                                                child: CachedNetworkImage(
                                                  imageUrl: (controller
                                                                  .productList[
                                                                      index]
                                                                  .image ??
                                                              '')
                                                          .contains(
                                                              'placeholder')
                                                      ? controller
                                                              .productList[
                                                                  index]
                                                              .image ??
                                                          "https://via.placeholder.com/200"
                                                      : 'https://storage.googleapis.com/${controller.productList[index].image}',
                                                  width: 132.h,
                                                  height: 132.h,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              controller
                                                  .productList[index].name!,
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              limitWord(controller
                                                  .productList[index]
                                                  .description!),
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp ',
                                                      decimalDigits: 0)
                                                  .format(controller
                                                      .productList[index]
                                                      .price!),
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget shimmerArrival() {
    return AppShimmer(
      child: GridView.builder(
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 50,
          ),
          itemCount: 10,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () => controller.goToDetail(controller.productList[index]),
              child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10).r),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(219, 219, 219, 100),
                          borderRadius: BorderRadius.circular(10).r),
                      child: Container(
                        width: 132.h,
                        height: 132.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                      ),
                    ),
                    ShimmerText(width: 100.w, height: 10.h),
                    ShimmerText(width: 100.w, height: 10.h),
                    ShimmerText(width: 100.w, height: 10.h),
                  ],
                ),
              ),
            );
          }),
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
