import 'package:client/pages/categories/categories/controllers/categories_controller.dart';
import 'package:client/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/app_shimmer.dart';

// ignore: must_be_immutable
class DetailCategory extends StatelessWidget {
  int categoryId;
  String categoryName;
  DetailCategory(this.categoryId, this.categoryName, {super.key});
  final CategoriesController categoryController =
      Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    final builder = categoryController.getCategoryById(categoryId);
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
            onPressed: () {
              //pergi ke halaman search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                categoryName,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
            FutureBuilder(
                future: builder,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmerDetailCategory();
                  }
                  if (categoryController.categoryId[0].products!.isEmpty) {
                    return Center(
                      child: Text('"No products in $categoryName category"'),
                    );
                  }
                  return GridView.builder(
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
                          categoryController.categoryId[0].products!.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppPages.detail,
                                arguments:
                                    categoryController.categoryId[0].products);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          219, 219, 219, 100),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    'https://storage.googleapis.com/${categoryController.categoryId[0].products![index].image!}',
                                    width: 132,
                                    height: 132,
                                  ),
                                ),
                                Text(
                                  categoryController
                                      .categoryId[0].products![index].name!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  categoryController.categoryId[0]
                                      .products![index].description!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(categoryController.categoryId[0]
                                          .products![index].price!),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
            //widget products
          ],
        ),
      ),
    );
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
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(219, 219, 219, 100),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: 132.h,
                        height: 132.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
