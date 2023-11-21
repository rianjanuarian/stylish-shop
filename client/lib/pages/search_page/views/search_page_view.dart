import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/search_page_controller.dart';
import 'package:client/pages/home_page/detail_product.dart';
class SearchPageView extends GetView<SearchPageController> {

  final SearchPageController searchController = Get.put(SearchPageController());
  TextEditingController textController = TextEditingController();
  SearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // productController.getProductById(widget.id!);
    searchController.searchProducts(textController.text);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
          onChanged: (text) {
            searchController.searchProducts(text);
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search...',
            contentPadding: EdgeInsets.zero,
            fillColor: const Color(0xffF3F4F5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (searchController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (searchController.productName.isEmpty) {
            return Center(
              child: Text('No results found.'),
            );
          }
          if (textController.text.isEmpty) {
            return Center(
              child: Text('Type something to search'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 10,
              ),
              itemCount: searchController.productName.length,
              itemBuilder: (context, index) {
                final product = searchController.productName[index];
          
                // return ListTile(
                //   title: Text(product.name!),
                // );
                return InkWell(
                  onTap: () {
                      Get.to(() => DetailProduct(
                                          product.id,
                                          product.image
                                        ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        //http://192.168.0.104:3000/uploads/${product.image}
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(219, 219, 219, 100),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            'https://storage.googleapis.com/${product.image!}',
                            width: 132,
                            height: 132,
                          ),
                        ),
                        Text(
                          product.name!,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          product.description!,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(product.price!),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
