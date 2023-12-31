import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../widgets/app_shimmer.dart';
import '../../../../widgets/custom_text.dart';
import '../../../profile/setting/controllers/setting_controller.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeScreenController>(HomeScreenController());
    final userController = Get.put<SettingController>(SettingController());
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: () => controller.getProducts(),
        showChildOpacityTransition: false,
        borderWidth: 2,
        backgroundColor: Colors.black,
        springAnimationDurationInMilliseconds: 200,
        color: Colors.white,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 80.h,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(30.h),
                  child: const SizedBox()),
              floating: false,
              pinned: true,
              surfaceTintColor: Colors.white,
              flexibleSpace: SafeArea(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Padding(
                      padding:
                          REdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: userController.isLoading.isTrue &&
                              userController.user.value == null
                          ? createShimmerAvatar()
                          : Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(32.5).r,
                                  child: CachedNetworkImage(
                                    imageUrl: (userController
                                                    .user.value?.image ??
                                                '')
                                            .contains('placeholder')
                                        ? userController.user.value?.image ??
                                            "https://via.placeholder.com/200"
                                        : 'https://storage.googleapis.com/${userController.user.value?.image}',
                                    width: 65.h,
                                    height: 65.h,
                                    fit: BoxFit.cover,
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
                                      userController.user.value?.name ??
                                          'Sarah Ann',
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
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Obx(
                    () => Column(
                      children: [
                        Padding(
                          padding: REdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: TextField(
                            onTap: () => controller.goToSearch(),
                            readOnly: true,
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                    REdgeInsets.symmetric(horizontal: 30.0),
                                child: Icon(Icons.search, size: 32.sp),
                              ),
                              hintText: 'Search...',
                              hintStyle:
                                  const TextStyle(color: Color(0xFFAAAAAA)),
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
                                              image:
                                                  AssetImage(coupon["image"]),
                                            ),
                                            color: const Color.fromRGBO(
                                                219, 219, 219, 100),
                                            borderRadius:
                                                BorderRadius.circular(10).r),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: REdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "${coupon["percent"]}% Off",
                                                    style: TextStyle(
                                                        fontSize: 25.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    coupon["title"],
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Padding(
                                                    padding: REdgeInsets.only(
                                                        top: 10.0,
                                                        bottom: 15.0),
                                                    child: Text(
                                                      "With code: ${coupon["code"]}",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff666666),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.black,
                                                            minimumSize: Size(
                                                                75.w, 30.h),
                                                            padding: EdgeInsets
                                                                .zero),
                                                    child: Text(
                                                      "Get Now",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
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
                            onTap: () => controller.goToNewArrival(),
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
                                              onTap: () => controller
                                                  .goToDetail(product),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                10)
                                                            .r),
                                                child: controller
                                                        .productList.isNotEmpty
                                                    ? Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                        .circular(
                                                                            10)
                                                                    .r,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: (product
                                                                              .image ??
                                                                          '')
                                                                      .contains(
                                                                          'placeholder')
                                                                  ? product
                                                                          .image ??
                                                                      "https://via.placeholder.com/200"
                                                                  : 'https://storage.googleapis.com/${product.image}',
                                                              height: 170.h,
                                                              width: 155.w,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                          Text(
                                                            product.name ??
                                                                "no product name",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Text(
                                                            limitWord(
                                                              product.description ??
                                                                  "no product description",
                                                            ),
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: const Color(
                                                                  0xFF666666),
                                                            ),
                                                          ),
                                                          Text(
                                                            NumberFormat.currency(
                                                                    locale:
                                                                        'id',
                                                                    symbol:
                                                                        'Rp ',
                                                                    decimalDigits:
                                                                        0)
                                                                .format(product
                                                                        .price ??
                                                                    0),
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
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
                              textNamed: 'Trending Products',
                              onTap: () => controller.goToTrendingProduct()),
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
                                            onTap: () =>
                                                controller.goToDetail(product),
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                          .r),
                                              child: controller
                                                      .trendingList.isNotEmpty
                                                  ? Column(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                      .circular(
                                                                          10)
                                                                  .r,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: (product
                                                                            .image ??
                                                                        '')
                                                                    .contains(
                                                                        'placeholder')
                                                                ? product
                                                                        .image ??
                                                                    "https://via.placeholder.com/200"
                                                                : 'https://storage.googleapis.com/${product.image}',
                                                            height: 170.h,
                                                            width: 155.w,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                        Text(
                                                          product.name ??
                                                              "no product name",
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                       Text(
                                                            limitWord(
                                                              product.description ??
                                                                  "no product description",
                                                            ),
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: const Color(
                                                                  0xFF666666),
                                                            ),
                                                          ),
                                                        Text(
                                                          NumberFormat.currency(
                                                                  locale: 'id',
                                                                  symbol: 'Rp ',
                                                                  decimalDigits:
                                                                      0)
                                                              .format(product
                                                                      .price ??
                                                                  0),
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createShimmerAvatar() {
    return AppShimmer(
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            child: const Column(),
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
        children: List.generate(
          4,
          (index) => Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: shimmerProducts(),
          ),
        ),
      ),
    );
  }

  Widget shimmerProducts() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: SizedBox(
              width: 150.w,
              height: 160.h,
            ),
          ),
          for (int i = 0; i < 3; i++) ShimmerText(width: 100.w, height: 10.h),
        ],
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
