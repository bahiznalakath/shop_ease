import 'package:get/get.dart';
import 'package:shop_ease/model/product_model.dart';
import 'package:shop_ease/providers/api_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ease/widgets/custom_snackbar.dart';
import 'package:shop_ease/widgets/show_loader_dialog.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs; // Observable cart items
  var isLoading = true.obs;
  var errorMessage = ''.obs; // To display any error message

  // @override
  // void onInit() {
  //   fetchCartData();
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  Future<void> fetchCartData() async {
    try {
      String userId =
          FirebaseAuth.instance.currentUser!.uid; // Get the current user ID
      print('Fetching cart for user: $userId');
      isLoading.value = true;
      final data = await ApiProvider().getData('carts', docId: userId);
      if (data != null) {
        cartItems.clear();
        List<dynamic> items = data['items'];
        for (var item in items) {
          Product product = Product(
            id: item['productId'],
            productName: item['productName'],
            productPrice: item['productPrice'],
            category: item['category'],
            imagePath: item['imagePath'],
          );
          cartItems[product] = item['quantity'];
        }
      } else {
        print('No cart data found');
        errorMessage.value = 'No cart data available';
      }
    } catch (e) {
      print('Error fetching cart data: $e');
      errorMessage.value = 'Failed to fetch cart data';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeItem(Product product) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    cartItems.remove(product);
    showLoaderDialog();
    bool isSuccess =
        await ApiProvider().removeItemFromCart(userId, product.id ?? "");
    if (isSuccess) {
      fetchCartData();
      Get.back();
      showCustomSnackBar("${product.productName} removed from cart!",
          isError: false);
    } else {
      showCustomSnackBar("Failed to remove item from cart", isError: true);
    }
  }
}
