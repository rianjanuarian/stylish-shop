import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish_shop/services/api_service/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  const DetailProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              width: 1.sw,
              height: 0.5.sh,
              color: const Color.fromRGBO(219, 219, 219, 100),
              child: CachedNetworkImage(
                imageUrl: (product.image ?? '').contains('placeholder')
                    ? product.image ?? "https://via.placeholder.com/200"
                    : 'https://storage.googleapis.com/${product.image}',
                width: 65.w,
                height: 0.5.sh,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: Get.back,
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
                        iconSize: 20.sp,
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 0.48.sh,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20).r,
                    topRight: const Radius.circular(20).r,
                  ),
                  child: Container(
                    height: 0.5.sh,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 1.sw,
                        ),
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                           
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name ?? " ",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(product.brands?[0].name ?? " "),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 100.w,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                219, 219, 219, 100),
                                            borderRadius:
                                                BorderRadius.circular(20).r),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap: () =>
                                                    controller.quantity.value >
                                                            1
                                                        ? controller
                                                            .substractQuantity()
                                                        : null,
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 15.sp,
                                                )),
                                            Obx(
                                              () => Text(controller.quantity
                                                  .toString()),
                                            ),
                                            InkWell(
                                              onTap: () =>
                                                  controller.quantity.value <
                                                          (product.stock ?? 0)
                                                      ? controller.addQuantity()
                                                      : null,
                                              child: Icon(
                                                Icons.add,
                                                size: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text('Stock : ${product.stock}')
                                    ],
                                  ),
                                ],
                              ),
                              //red green blue yellow

                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Color",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 80.h,
                                width: 1.sw,
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product.colors?.length ?? 0,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      var colorlist = product.colors![index];
                                      Color color =
                                          getColorFromString(colorlist);
                                      return InkWell(
                                        onTap: () =>
                                            controller.changeColor(color),
                                        highlightColor: Colors.red,
                                        child: Obx(
                                          () => Container(
                                            width: 50.h,
                                            height: 50.h,
                                            margin: REdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: color,
                                              border: Border.all(
                                                  width: 2.w,
                                                  color: controller
                                                              .selectedColor
                                                              .value ==
                                                          color
                                                      ? Colors.black
                                                      : Colors.white),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 75.h,
                                child: SingleChildScrollView(
                                  child: Text(
                                    product.description ?? 'No Description',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Total Price",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 10.sp),
                                      ),
                                      Obx(
                                        () => Text(
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: 'Rp ',
                                                  decimalDigits: 0)
                                              .format(controller.price.value),
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        controller.addToCart(product.id ?? 0),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    icon: const Icon(
                                      Icons.shopping_basket_outlined,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Add to cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
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
