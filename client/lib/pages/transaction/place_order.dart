import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/services/api_service/cart/cart_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../cart/views/cart_view.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final List order = [
      {
        'image':
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Roller Rabbit',
        'description': 'Vado Odelle Dress',
        'price': 198,
        'quantity': 1,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Axel Arigato',
        'description': 'Clean 90 Triole Snakers',
        'price': 245,
        'quantity': 1,
      },
    ];
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70.h,
        padding: REdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, -4))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$433.00',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.white),
              child: const Text('Place Order'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leadingWidth: 80.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          style: IconButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFD9D9D9),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10).r,
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Product Item',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              // ...order
              //     .asMap()
              //     .entries
              //     .map((order) => CartItem(
              //           cart: Cart()
              //         ))
              //     .toList(),
              Text(
                'Courier',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 20.h),
              _Courier(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Courier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: REdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(30).r,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://id.wikipedia.org/wiki/Berkas:New_Logo_JNE.png',
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'JNE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('\$15')
                ],
              ),
            ],
          ),
          Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20).r,
              child: InkWell(
                  onLongPress: () {},
                  borderRadius: BorderRadius.circular(20).r,
                  child: const Icon(Icons.expand_more)))
        ],
      ),
    );
  }
}
