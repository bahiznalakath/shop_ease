import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/product_list_controller.dart';

import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/resources/dimensions.dart';
import 'package:shop_ease/widgets/app_background_widget.dart';
import 'package:shop_ease/widgets/custom_app_bar.dart';

class ProductListScreen extends StatelessWidget {
  final ProductListController controller = Get.put(ProductListController());

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const CustomAppBar(title: 'Product List'),
      body: Obx(() {
        return AppBackground(
          child: ListView(
            padding: EdgeInsets.all(mobilePadding),
            children: [
              controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(color: primaryColor,),
                    )
                  : controller.productList.isEmpty
                      ? const Center(
                          child: Text(
                            'No products available.',
                            // style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16.0),
                          itemCount: controller.productList.length,
                          itemBuilder: (context, index) {
                            var product = controller.productList[index];
                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: product.imagePath!.isNotEmpty
                                    ? Image.network(
                                        product.imagePath??"",
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Icon(Icons.image_not_supported),
                                      )
                                    : const Icon(Icons.image),
                                title: Text(
                                  product.productName??"",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Code: ${product.productCode}'),
                                    Text('Category: ${product.category}'),
                                    Text(
                                      'Price: \$${product.productPrice!.toStringAsFixed(2)}',
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon:
                                      const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    controller.deleteProduct(product.id??"");
                                  },
                                ),
                              ),
                            );
                          },
                        ),
            ],
          ),
        );
      }),
    );
  }
}
