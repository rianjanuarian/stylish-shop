import 'package:client/controller/product_controller.dart';
import 'package:client/models/products.dart';
import 'package:client/pages/home_page/new_arrival.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailProduct extends StatelessWidget {
  int? id, price;
  String? imageUrl;
  DetailProduct(this.id, this.imageUrl, {super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    productController.getProductById(id!);
    return Scaffold(
        body: Column(
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
                     Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
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
                    height: MediaQuery.of(context).size.height * 0.5,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            productController
                                                    .productId.isNotEmpty
                                                ? Text(
                                                    productController
                                                            .productId[0]
                                                            .name ??
                                                        " ",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : Container(),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          219, 219, 219, 100),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {productController.decrement();},
                                                          child: Text("-")),
                                                      Text(productController.counter.value.toString()),
                                                        productController
                                                        .productId.isNotEmpty ?
                                                      InkWell(
                                                          onTap: () {productController.increment(productController.productId[0].stock!);},
                                                          child: Text("+")): Container()
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                productController
                                                        .productId.isNotEmpty
                                                    ? Text(
                                                        'Stock : ${productController.productId[0].stock}')
                                                    : Container()
                                              ],
                                            ),
                                          ],
                                        ),
                                        //red green blue yellow
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Color",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        productController.productId.isNotEmpty
                                            ? SizedBox(
                                                height: 80,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: productController
                                                            .productId
                                                            .isNotEmpty
                                                        ? productController
                                                            .productId[0]
                                                            .colors!
                                                            .length
                                                        : 0,
                                                    itemBuilder:
                                                        (BuildContext ctx,
                                                            int index) {
                                                      var colorlist =
                                                          productController
                                                              .productId[0]
                                                              .colors![index];
                                                      Color color =
                                                          getColorFromString(
                                                              colorlist);
                                                      return InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          margin:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: color,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        productController
                                                            .productId
                                                            .isNotEmpty ?
                                        Text(
                                          productController
                                              .productId[0].description!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ) : Container(),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Total Price",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 10),
                                                ),
                                                 productController
                                                            .productId
                                                            .isNotEmpty ?
                                                Text(
                                                  NumberFormat.currency(
                                                          locale: 'id',
                                                          symbol: 'Rp ',
                                                          decimalDigits: 0)
                                                      .format(
                                                        productController.counter.value == 0 ?
                                                        productController
                                                          .productId[0].price! : productController
                                                          .productId[0].price! * productController.counter.value),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ) : Container()
                                              ],
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons
                                                        .shopping_basket_outlined,color: Colors.white,),
                                                        SizedBox(width: 10,),
                                                        Text("Add to cart",style: TextStyle(color: Colors.white),)
                                                  ],
                                                ))
                                          ],
                                        )
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
    ));
  }

  Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;

      default:
        return Colors.white;
    }
  }
}
