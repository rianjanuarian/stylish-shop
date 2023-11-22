import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/pages/profile/setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../services/api_service/user/user_service_models.dart';
import '../../../../widgets/app_shimmer.dart';
import '../../../../widgets/custom_text.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomeScreenController>(HomeScreenController());
    final userController = Get.put<SettingController>(SettingController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: FutureBuilder(
            future: userController.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: 1.sh,
                    child: const Center(child: CircularProgressIndicator()));
              }
              final UserModel? user = snapshot.data;
              return Column(
                children: [
                  Padding(
                    padding:
                        REdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50).r,
                          child: CachedNetworkImage(
                            imageUrl: (user?.image ?? '')
                                    .contains('placeholder')
                                ? user?.image ??
                                    "https://via.placeholder.com/200"
                                : 'https://storage.googleapis.com/${user?.image}',
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
                              user?.name ?? 'Sarah Ann',
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
                    padding:
                        REdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                                                  color:
                                                      const Color(0xff666666),
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
                      textNamed: 'New Arrivals',
                      onTap: controller.goToNewArrival,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 30),
                      child: Wrap(
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
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 30),
                    child: CustomText(
                      textNamed: 'Trending Product',
                      onTap: controller.goToNewArrival,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 30),
                      child: Wrap(
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
                                  child: controller.productList.isNotEmpty
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget createShimmerApp() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (_, index) {
          return AppShimmer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(219, 219, 219, 100),
                              borderRadius: BorderRadius.circular(10)),
                          child: const SizedBox(
                            width: 150,
                            height: 80,
                          )),
                      const ShimmerText(),
                      const ShimmerText(),
                      const ShimmerText(),
                    ],
                  )),
            ),
          );
        });
  }
}
