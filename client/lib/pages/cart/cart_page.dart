import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map> dummyCarts = [
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
      {
        'image':
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Herschel Supply Co.',
        'description': 'Daypack Backpack',
        'price': 40,
        'quantity': 1,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Roller Rabbah',
        'description': 'Nasi Goreng Lemak',
        'price': 40,
        'quantity': 2,
      },
      {
        'image':
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'Roller Rabbah',
        'description': 'Nasi Goreng Lemak',
        'price': 40,
        'quantity': 2,
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text('My Cart',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              SizedBox(height: 20.h),
              ...dummyCarts
                  .asMap()
                  .entries
                  .map((cart) => CartItem(
                        keyItem: cart.key,
                        title: cart.value['title'],
                        image: cart.value['image'],
                        description: cart.value['description'],
                        price: cart.value['price'],
                        quantity: cart.value['quantity'],
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.keyItem,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.quantity});
  final int keyItem;
  final String image;
  final String title;
  final String description;
  final int price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 20),
      child: Slidable(
        key: ValueKey(keyItem),
        endActionPane: ActionPane(
            dragDismissible: false,
            extentRatio: 0.3,
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (ctx) {
                  showDeleteConfirmationDialog(ctx);
                  //delete
                },
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(13).r,
                    bottomRight: const Radius.circular(13).r),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
        child: Container(
          width: double.infinity,
          height: 100.h,
          padding: REdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13).r,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10).r,
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14.sp),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                                color: const Color(0xff666666),
                                fontSize: 11.sp),
                          ),
                        ],
                      ),
                      Text(
                        '\$$price.00',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 30.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(30).r,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // IconButton(onPressed: () {}, icon: const Icon(Icons.add), constraints: const BoxConstraints(), iconSize: 14, padding: EdgeInsets.zero,),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          //substract the quantity
                        },
                        child: const Icon(Icons.remove, size: 16),
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          //add the quantity
                        },
                        child: const Icon(Icons.add, size: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showDeleteConfirmationDialog(BuildContext context) {
  Get.defaultDialog(
    title: 'Confirmation',
    middleText: 'Are you sure you want to delete this item?',
    textConfirm: 'Delete',
    textCancel: 'Cancel',
    confirmTextColor: Colors.white,
    onCancel: () => Get.back(),
    onConfirm: () {
      // Haapos barang
      Get.back();
    },
  );
}


// Dismissible(
//         key: ValueKey(widget.keyItem),
//         direction: DismissDirection.endToStart,
//         dismissThresholds: const {
//           DismissDirection.endToStart: 0.5
//         },
//         background: Container(
//           width: 0.4.sh,
//           padding: REdgeInsets.only(right: 20),
//           alignment: Alignment.centerRight,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.only(
//                 topRight: const Radius.circular(13).r,
//                 bottomRight: const Radius.circular(13).r),
//           ),
//           child: const Icon(
//             Icons.delete,
//             color: Colors.white,
//           ),
//         ),
//         child: Container(
//           width: double.infinity,
//           height: 100.h,
//           padding: REdgeInsets.all(10),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(13).r,
//               boxShadow: const [
//                 BoxShadow(
//                     color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))
//               ]),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10).r,
//                     child: CachedNetworkImage(
//                       imageUrl: widget.image,
//                       width: 80.w,
//                       height: 80.h,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) =>
//                           const Center(child: CircularProgressIndicator()),
//                       errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                     ),
//                   ),
//                   SizedBox(width: 20.w),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.title,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700, fontSize: 14.sp),
//                           ),
//                           Text(
//                             widget.description,
//                             style: TextStyle(
//                                 color: const Color(0xff666666),
//                                 fontSize: 11.sp),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         '\$${widget.price}.00',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w900, fontSize: 14.sp),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Container(
//                 height: 30.h,
//                 width: 70.w,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEEEEEE),
//                   borderRadius: BorderRadius.circular(30).r,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // IconButton(onPressed: () {}, icon: const Icon(Icons.add), constraints: const BoxConstraints(), iconSize: 14, padding: EdgeInsets.zero,),
//                     Material(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.circular(20),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(20),
//                         onTap: () {
//                           //substract the quantity
//                         },
//                         child: const Icon(Icons.remove, size: 16),
//                       ),
//                     ),
//                     Text(
//                       widget.quantity.toString(),
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                     Material(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.circular(20),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(20),
//                         onTap: () {
//                           //add the quantity
//                         },
//                         child: const Icon(Icons.add, size: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),