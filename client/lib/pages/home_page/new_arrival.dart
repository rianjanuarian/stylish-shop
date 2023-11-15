import 'package:client/controller/product_controller.dart';
import 'package:client/models/products.dart';
import 'package:client/pages/home_page/detail_product.dart';
import 'package:client/pages/home_page/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewArrival extends StatelessWidget {
  const NewArrival({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ProductController>(ProductController());
    List<Products> productList = controller.productList;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.off(() => HomeScreen()),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    color: Colors.white,
                    style: IconButton.styleFrom(
                        iconSize: 40,
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Arrivals",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 1,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 50,
                              ),
                              itemCount: productList.length,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DetailProduct(
                                          productList[index].id,
                                          productList[index].image,
                                         
                                        ));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        //http://192.168.0.104:3000/uploads/${product.image}
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  219, 219, 219, 100),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Image.network(
                                            'http://192.168.0.104:3000/uploads/${productList[index].image!}',
                                            width: 132,
                                            height: 132,
                                          ),
                                        ),
                                        Text(
                                          productList[index].name!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          productList[index].description!,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: 'Rp ',
                                                  decimalDigits: 0)
                                              .format(
                                                  productList[index].price!),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
