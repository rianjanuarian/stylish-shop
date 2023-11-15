import 'package:client/controller/product_controller.dart';
import 'package:client/models/products.dart';
import 'package:client/pages/home_page/new_arrival.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailProduct extends StatelessWidget {
  int? id, price;
  String? imageUrl;
  DetailProduct(this.id, this.imageUrl, {super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    productController.getProductById(id!);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                color: Color.fromRGBO(219, 219, 219, 100),
                child: Image.network(
                  'http://192.168.0.104:3000/uploads/$imageUrl',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.off(() => const NewArrival());
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_basket_outlined,
                        color: Colors.black,
                      ),
                      color: Colors.white,
                      style: IconButton.styleFrom(
                          iconSize: 20,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.48,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20).w,
                      topRight: const Radius.circular(20).w,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, right: 12),
                              child: Obx(
                                () => productController.isLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                productController
                                                        .productId[0].name ??
                                                    " ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Container(width: 100,color: Colors.amber,child: Text("data"),)
                                            ],
                                          ),
                                        ],
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
