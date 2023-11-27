import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_shimmer.dart';
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
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                  ? shimmerCategory()
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
                                callback: () =>
                                    controller.goToDetailCategory(category.id!),
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

Widget shimmerCategory() {
  return AppShimmer(
    child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (_, index) {
          return InkWell(
            child: Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: REdgeInsets.only(top: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(219, 219, 219, 100),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
  );
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.callback,
  });
  final String categoryName;
  final int categoryId;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30).r,
        child: InkWell(
          borderRadius: BorderRadius.circular(30).r,
          onTap: callback,
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
