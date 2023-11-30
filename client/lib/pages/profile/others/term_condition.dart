import 'package:stylish_shop/pages/profile/others/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    const policyList = [
      'Lorem ipsum dolor sit amet consectetur. Sagittis in vehicula vitae consectetur sed tortor. Eu curabitur lobortis a sed augue. Velit est iaculis cursus tortor hac morbi massa proin. Dolor eu ultrices auctor duis egestas et ullamcorper dictum mi. Tristique sollicitudin fermentum bibendum curabitur ut fames sollicitudin urna.',
      'Sodales massa fames quis volutpat faucibus pulvinar. Diam sed eu morbi at in ut fringilla pulvinar habitant. Orci eget varius enim quam aliquam odio. Felis augue lorem sit commodo fames tellus sagittis faucibus. Et sit hac odio etiam feugiat suscipit sit. In nulla ullamcorper vitae eget placerat tincidunt. Elementum massa consequat duis etiam leo sem sed. Sed natoque arcu blandit nunc pharetra neque.',
      'Nunc purus integer volutpat suscipit porta lobortis nec est ac. Nisl maecenas scelerisque iaculis in tellus fringilla ac mattis interdum. Euismod gravida ac amet lacus imperdiet aenean quam id. Aliquam congue mi aliquam senectus pharetra vel nunc id. Donec aliquet sit integer non varius. Id est scelerisque interdum viverra nulla a.',
    ];

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
        title: Text(
          'Term & Conditions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ketentuan Hukum',
                style:
                    TextStyle(fontSize: 14.sp, color: const Color(0xFF595959)),
              ),
              SizedBox(height: 10.h),
              Text(
                'Term Condition',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20.h),
              Text(
                'Pendahuluan',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              ...policyList
                  .asMap()
                  .entries
                  .map((policy) => ListTileParagraph(
                      number: policy.key + 1, content: policy.value))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
