import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> categoryDummies = [
      'New Arivals',
      'Clothes',
      'Bags',
      'Shoes',
      'Electronics',
      'Jewelery'
    ];

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                onTap: () {
                  //pergi ke halaman search
                },
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
              ...categoryDummies
                  .map((category) => CategoryItem(categoryName: category))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryName});
  final String categoryName;

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
            //detail category
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
              )),
        ),
      ),
    );
  }
}
