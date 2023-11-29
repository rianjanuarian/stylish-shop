import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../../widgets/app_shimmer.dart';
import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => controller.goToSearch(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => controller.isLoading.isTrue
              ? shimmerDetailCategory()
              : controller.category.value!.products!.isEmpty
                  ? Column(
                      children: [
                        Lottie.asset('assets/animations/empty.json',
                            height: 0.7.sh, width: double.infinity),
                        Text(
                          'No products in category "${controller.category.value?.name}"',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: REdgeInsets.all(30.0),
                          child: Text(
                            controller.category.value?.name ?? "unknown",
                            style: TextStyle(
                                fontSize: 28.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 1,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 50,
                          ),
                          itemCount:
                              controller.category.value?.products!.length,
                          itemBuilder: (_, index) {
                            final product =
                                controller.category.value?.products![index];
                            return InkWell(
                              onTap: () => controller.goToDetail(product),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15).r,
                                    child: CachedNetworkImage(
                                      imageUrl: (product?.image ??
                                                  "https://via.placeholder.com/200")
                                              .contains('placeholder')
                                          ? "https://via.placeholder.com/200"
                                          : 'https://storage.googleapis.com/${product?.image}',
                                      width: 132.h,
                                      height: 132.h,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Text(
                                    product?.name ?? 'No Name',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    limitWord(product?.description ??
                                        'No Description'),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(product?.price),
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

Widget shimmerDetailCategory() {
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

String limitWord(String text) {
  List<String> words = text.split(' ');

  if (words.length <= 3) {
    return text;
  } else {
    return '${words.take(3).join(' ')}...';
  }
}
