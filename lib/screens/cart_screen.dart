import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/cart_controller.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/widgets/app_background_widget.dart';
import 'package:shop_ease/widgets/custom_app_bar.dart';


class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    controller.fetchCartData();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const CustomAppBar(title: 'Cart', isBack: false),
      body: AppBackground(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  Text(
                    'Your cart is empty!',
                    style: TextStyle(fontSize: 18, color: colorMediumGrey),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                var product = controller.cartItems.keys.toList()[index];
                int quantity = controller.cartItems[product]!;

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
                  title: Text(
                    product.productName??"",
                    style: TextStyle(fontSize: 18, color:colorMediumGrey),
                  ),
                  subtitle: Text(
                    'Price: \$${product.productPrice} | Quantity: $quantity',
                    style: TextStyle(fontSize: 14, color:colorMediumGrey),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      controller.removeItem(product);
                    },
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
