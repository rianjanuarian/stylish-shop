import 'package:client/pages/categories/detail_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<CategoriesController>(CategoriesController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                onTap: () => controller.goToSearch(),
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
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        ...controller.categoriesList
                            .map(
                              (category) => CategoryItem(
                                categoryId: category.id!,
                                categoryName: category.name!,
                              ),
                            )
                            .toList(),
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryItem({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });
  final String categoryName;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30).r,
        child: InkWell(
          borderRadius: BorderRadius.circular(30).r,
          onTap: () {
            Get.to(() => DetailCategory(categoryId, categoryName));
          },
          child: Container(
            padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30).r,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.radio_button_unchecked,
                  color: Colors.white,
                ),
                SizedBox(width: 20.w),
                Text(
                  categoryName,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
