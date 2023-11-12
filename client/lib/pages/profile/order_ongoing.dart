import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderOngoing extends StatefulWidget {
  const OrderOngoing({super.key});

  @override
  State<OrderOngoing> createState() => _OrderOngoingState();
}

class _OrderOngoingState extends State<OrderOngoing> {
  final List _orderOnGoing = [
    {
      'image': 'http://via.placeholder.com/200',
      'title': 'Adibas',
      'description': 'Adibas good shoes',
      'price': 150,
    },
    {
      'image': 'http://via.placeholder.com/200',
      'title': 'Mike',
      'description': 'Mike good shoes',
      'price': 170,
    }
  ];

  final List _orderCompleted = [
    {
      'image': 'http://via.placeholder.com/200',
      'title': 'Swallaw',
      'description': 'Swallaw good sandals',
      'price': 150,
    }
  ];

  bool _isOngoing = false;

  void _switchTo(bool isOngoing) {
    setState(() {
      _isOngoing = isOngoing;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              'My Order',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32.sp),
            ),
            SizedBox(height: 20.h),
            Container(
              height: 60.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFf0f0f0),
                  borderRadius: BorderRadius.circular(10).r),
              child: Padding(
                padding: REdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _switchTo(true),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: _isOngoing ? Colors.black : null,
                          borderRadius: BorderRadius.circular(7).r,
                        ),
                        width: 165.w,
                        height: 40.h,
                        child: Center(
                          child: Text(
                            'Ongoing',
                            style: TextStyle(
                              color: _isOngoing ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _switchTo(false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: !_isOngoing ? Colors.black : null,
                          borderRadius: BorderRadius.circular(7).r,
                        ),
                        width: 165.w,
                        height: 40.h,
                        child: Center(
                          child: Text(
                            'Completed',
                            style: TextStyle(
                              color: !_isOngoing ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _isOngoing
                      ? _orderOnGoing
                          .map((order) => _OrderWidget(
                                title: order['title'],
                                description: order['description'],
                                image: order['image'],
                                price: order['price'],
                              ))
                          .toList()
                      : _orderCompleted
                          .map((order) => _OrderWidget(
                                title: order['title'],
                                description: order['description'],
                                image: order['image'],
                                price: order['price'],
                              ))
                          .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderWidget extends StatelessWidget {
  const _OrderWidget(
      {required this.image,
      required this.title,
      required this.description,
      required this.price});
  final String image;
  final String title;
  final String description;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 1.sw,
      margin: REdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10).r,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 5.0, offset: Offset(2, 3))
          ]),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5).r,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: 80.w,
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E8E)),
                    )
                  ],
                ),
              ],
            ),
            Text(
              '\$$price.00',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
