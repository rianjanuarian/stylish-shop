import 'package:client/controller/product_controller.dart';
import 'package:client/models/products.dart';
import 'package:client/pages/home_page/detail_product.dart';
import 'package:client/pages/search_page/views/search_page_view.dart';
import 'package:client/widgets/app_shimmer.dart';
import 'package:client/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/app_pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ProductController>(ProductController());
    controller.trendingProducts();
    List<Products> productList = controller.productList;

    List<Products> trendingProducts = controller.trendingList;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    StreamBuilder<User?>(
                        stream: FirebaseAuth.instance.userChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                FirebaseAuth.instance.currentUser!.photoURL!,
                                width: 65,
                                height: 65,
                              ),
                            );
                          } else {
                            //masukin data yg login pake akun postgre
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset('assets/images/user.png'),
                            );
                          }
                        }),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Happy Shopping!',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        StreamBuilder<User?>(
                            stream: FirebaseAuth.instance.userChanges(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  FirebaseAuth
                                      .instance.currentUser!.displayName!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF666666)),
                                );
                              } else {
                                //masukin data yg login pake akun postgre
                                return const Text(
                                  'Sarah Ann',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF666666)),
                                );
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){
                  Get.to(() => SearchPageView());
                }, child: const Row(
                  children: [
                    Icon(Icons.search,color: Colors.black,),
                    SizedBox(width: 15,),
                    Text("Search...",style: TextStyle(color: Colors.black),),
                  ],
                ))
              ),
              // TextField(
              //     decoration: InputDecoration(
              //       prefixIcon: const Icon(Icons.search),
              //       hintText: 'Search...',
              //       contentPadding: EdgeInsets.zero,
              //       fillColor: const Color(0xffF3F4F5),
              //       filled: true,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //     ),
              //   ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/diskon1.png'),
                            ),
                            color: const Color.fromRGBO(219, 219, 219, 100),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "50% Off",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text(
                                    "On everything today",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 15.0),
                                    child: Text("With code: FSCREATION"),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black),
                                      child: const Text(
                                        "Get Now",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/diskon2.png'),
                            ),
                            color: const Color.fromRGBO(219, 219, 219, 100),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "70% Off",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Text(
                                    "On shirt today",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 15.0),
                                    child: Text("With code: STYLECODE"),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black),
                                      child: const Text(
                                        "Get Now",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomText(
                textNamed: 'New Arrivals',
                onTap: () => Get.toNamed(AppPages.newArrival),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Obx(
                    () => controller.isLoading.value
                        ? createShimmerApp()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productList.length == 6
                                ? 6
                                : productList.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => DetailProduct(
                                      productList.isNotEmpty
                                          ? productList[index].id
                                          : 0,
                                      productList.isNotEmpty
                                          ? productList[index].image
                                          : ''));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: productList.isNotEmpty
                                          ? Column(
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color.fromRGBO(
                                                            219, 219, 219, 100),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Image.network(
                                                      productList[index]
                                                              .image!
                                                              .isNotEmpty
                                                          ? 'https://storage.googleapis.com/${productList[index].image!}'
                                                          : "",
                                                      width: 150,
                                                      height: 80,
                                                    )),
                                                Text(
                                                  productList[index].name!,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  productList[index]
                                                      .description!,
                                                  style:
                                                      const TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          locale: 'id',
                                                          symbol: 'Rp ',
                                                          decimalDigits: 0)
                                                      .format(productList[index]
                                                          .price!),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            )
                                          : Container()),
                                ),
                              );
                            }),
                  )),
              CustomText(
                textNamed: 'Trending Products',
                onTap: () {},
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Obx(
                    () => controller.isLoading.value
                        ? createShimmerApp()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: trendingProducts.length == 6
                                ? 6
                                : trendingProducts.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => DetailProduct(
                                        trendingProducts.isNotEmpty
                                            ? trendingProducts[index].id
                                            : 0,
                                        trendingProducts.isNotEmpty
                                            ? trendingProducts[index].image
                                            : '',
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: trendingProducts.isNotEmpty
                                          ? Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: const Color.fromRGBO(
                                                          219, 219, 219, 100),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Image.network(
                                                    trendingProducts[index]
                                                            .image!
                                                            .isNotEmpty
                                                        ? 'https://storage.googleapis.com/${trendingProducts[index].image!}'
                                                        : "",
                                                    width: 150,
                                                    height: 80,
                                                  ),
                                                ),
                                                Text(
                                                  trendingProducts[index].name!,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  trendingProducts[index]
                                                      .description!,
                                                  style:
                                                      const TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          locale: 'id',
                                                          symbol: 'Rp ',
                                                          decimalDigits: 0)
                                                      .format(trendingProducts[
                                                              index]
                                                          .price!),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            )
                                          : Container()),
                                ),
                              );
                            }),
                  )),
            ],
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
