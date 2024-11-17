import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/user_home_controller.dart';
import 'package:shop_ease/model/product_model.dart';
import 'package:shop_ease/resources/dimensions.dart';
import 'package:shop_ease/screens/home/widgets/slider_banner_home.dart';
import 'package:shop_ease/widgets/mobile_button_add.dart';

class UserHome extends StatelessWidget {
  UserHome({super.key});

  final UserHomeController controller = Get.put(UserHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchProducts();
          },
          child: ListView(
            children: [
              kHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kWidth30,
                  Text(
                    "Hi, ",
                    style: TextStyle(
                      fontSize: 20.w,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    controller.userName.value,
                    style: TextStyle(
                      fontSize: 25.w,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              kHeight,
              SliderBannerHome(
                bannerImages: controller.listOfImages,
              ),
              kHeight20,
              Obx(() {
                if (controller.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.products.entries.map((entry) {
                    String category = entry.key;
                    List<Product> categoryProducts = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Header
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 22.w,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // List of Products
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categoryProducts.length,
                          itemBuilder: (context, index) {
                            Product product = categoryProducts[index];
                            return ListTile(
                              leading: Image.network(
                                product.imagePath??"",
                                width: 50.w,
                                height: 50.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image_not_supported,
                                    size: 50.w,
                                    color: Colors.grey,
                                  );
                                },
                              ),

                              title: Text(product.productName??""),
                              subtitle: Text(
                                "\$${product.productPrice?.toStringAsFixed(2)}",
                              ),
                              trailing: MobileButtonAdd(
                                onTap: () {
                                  controller.addToCart(product);
                                },
                              ),
                              // trailing: ElevatedButton(
                              //   onPressed: () {
                              //    controller.addToCart(product);
                              //   },
                              //   child: const Text("Add to Cart"),
                              // ),
                            );
                          },
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
