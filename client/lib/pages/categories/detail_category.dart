import 'package:client/pages/categories/categories/controllers/categories_controller.dart';
import 'package:client/pages/home_page/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailCategory extends StatelessWidget {
  int categoryId;
  String categoryName;
  DetailCategory(this.categoryId, this.categoryName, {super.key});
  final CategoriesController categoryController =
      Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    categoryController.getCategoryById(categoryId);
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
            Obx(
              () => categoryController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : categoryController.categoryId[0].products!.isEmpty
                      ? Center(child: Text("No products in $categoryName category"))
                      : GridView.builder(
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
                                Get.to(() => DetailProduct(
                                    categoryController
                                        .categoryId[0].products![index].id,
                                    categoryController
                                        .categoryId[0].products![index].image));
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                          .format(categoryController
                                              .categoryId[0]
                                              .products![index]
                                              .price!),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
            )
            //widget products
          ],
        ),
      ),
    );
  }
}
