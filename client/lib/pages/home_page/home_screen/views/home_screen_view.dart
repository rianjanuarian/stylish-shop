import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/app_shimmer.dart';
import '../../../../widgets/custom_text.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeScreenController>(HomeScreenController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: controller.isLoading.isTrue && controller.user == null
                  ? createShimmerAvatar()
                  : Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50).r,
                          child: CachedNetworkImage(
                            imageUrl: (controller.user?.image ?? '')
                                    .contains('placeholder')
                                ? controller.user?.image ??
                                    "https://via.placeholder.com/200"
                                : 'https://storage.googleapis.com/${controller.user?.image}',
                            width: 65.h,
                            height: 65.h,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Happy Shopping!',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              controller.user?.name ?? 'Sarah Ann',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: TextField(
                onTap: () => controller.goToSearch(),
                readOnly: true,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 30),
                  child: Wrap(
                    spacing: 20.w,
                    children: controller.dummyCoupon
                        .map(
                          (coupon) => Container(
                            height: 180.h,
                            width: 300.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(coupon["image"]),
                                ),
                                color: const Color.fromRGBO(219, 219, 219, 100),
                                borderRadius: BorderRadius.circular(10).r),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: REdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${coupon["percent"]}% Off",
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        coupon["title"],
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: REdgeInsets.only(
                                            top: 10.0, bottom: 15.0),
                                        child: Text(
                                          "With code: ${coupon["code"]}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff666666),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            minimumSize: Size(75.w, 30.h),
                                            padding: EdgeInsets.zero),
                                        child: Text(
                                          "Get Now",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 30),
              child: CustomText(
                textNamed: 'New Arrival',
                onTap: controller.goToNewArrival,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Obx(
                () => Padding(
                  padding: REdgeInsets.symmetric(horizontal: 30),
                  child: controller.isLoading.isTrue
                      ? createShimmerApp()
                      : Wrap(
                          spacing: 20.w,
                          children: controller.productList
                              .map(
                                (product) => InkWell(
                                  onTap: () => controller.goToDetail(product),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10).r),
                                    child: controller.productList.isNotEmpty
                                        ? Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10).r,
                                                child: CachedNetworkImage(
                                                  imageUrl: (product.image ??
                                                              '')
                                                          .contains(
                                                              'placeholder')
                                                      ? product.image ??
                                                          "https://via.placeholder.com/200"
                                                      : 'https://storage.googleapis.com/${product.image}',
                                                  height: 170.h,
                                                  width: 155.w,
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
                                              Text(
                                                product.name ??
                                                    "no product name",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                product.description ??
                                                    "no product description",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: const Color(
                                                        0xFF666666)),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp ',
                                                        decimalDigits: 0)
                                                    .format(product.price ?? 0),
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          )
                                        : Container(),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 30),
              child: CustomText(
                textNamed: 'Trending Product',
                onTap: controller.goToNewArrival,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 30),
                child: controller.isLoading.isTrue
                    ? createShimmerApp()
                    : Wrap(
                        spacing: 20.w,
                        children: controller.trendingList
                            .map(
                              (product) => InkWell(
                                onTap: () => controller.goToDetail(product),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10).r),
                                  child: controller.trendingList.isNotEmpty
                                      ? Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10).r,
                                              child: CachedNetworkImage(
                                                imageUrl: (product.image ?? '')
                                                        .contains('placeholder')
                                                    ? product.image ??
                                                        "https://via.placeholder.com/200"
                                                    : 'https://storage.googleapis.com/${product.image}',
                                                height: 170.h,
                                                width: 155.w,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            Text(
                                              product.name ?? "no product name",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              product.description ??
                                                  "no product description",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color:
                                                      const Color(0xFF666666)),
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp ',
                                                      decimalDigits: 0)
                                                  .format(product.price ?? 0),
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        )
                                      : Container(),
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget createShimmerAvatar() {
    return AppShimmer(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Column(),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerText(
                width: 235.w,
                height: 20.h,
              ),
              ShimmerText(
                width: 70.w,
                height: 20.h,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget createShimmerApp() {
    return AppShimmer(
      child: Row(
        children: [
          createShimmerProduct(),
          SizedBox(width: 20.w),
          createShimmerProduct(),
          SizedBox(width: 20.w),
          createShimmerProduct(),
          SizedBox(width: 20.w),
          createShimmerProduct(),
        ],
      ),
    );
  }

  Widget createShimmerProduct() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10).r),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                width: 150.w,
                height: 160.h,
              )),
          ShimmerText(width: 100.w, height: 10.h),
          ShimmerText(width: 100.w, height: 10.h),
          ShimmerText(width: 100.w, height: 10.h),
        ],
      ),
    );
  }
}
