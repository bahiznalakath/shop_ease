import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop_ease/model/product_model.dart';
import 'package:shop_ease/providers/api_provider.dart';
import 'package:shop_ease/providers/shared_preference/shared_storage.dart';
import 'package:shop_ease/resources/constants.dart';
import 'package:shop_ease/resources/images.dart';
import 'package:shop_ease/widgets/custom_snackbar.dart';
import 'package:shop_ease/widgets/show_loader_dialog.dart';

class UserHomeController extends GetxController {
  var listOfImages = [bannerImg1, bannerImg2];
  var userName = "".obs;

  getSharedData() async {
    userName.value = await SharedStorage().getSharedData(AppConstants.userName);
  }

  var categories = ["Electronics", "Fashion", "Groceries", "Books", "Toys"];
  var products = <String, List<Product>>{}.obs;

  fetchProducts() async {
    // showLoaderDialog();
    for (String category in categories) {
      final response = await ApiProvider().getData('products');
      if (response != null && response["documents"] != null) {
        var productList = (response["documents"] as List)
            .map((data) => Product.fromFirestore(data, data["id"]))
            .where((product) => product.category == category)
            .toList();
        products[category] = productList;

      }
    }
    // Get.back();
  }

  var cartItems = <Product, int>{}.obs;

  Future<void> addToCart(
    Product product,
  ) async {
    showLoaderDialog();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      if (cartItems.containsKey(product)) {
        cartItems[product] = cartItems[product]! + 1;
      } else {
        cartItems[product] = 1;
      }
      final cartData = cartItems.entries.map((entry) {
        return {
          "productId": entry.key.id,
          "productName": entry.key.productName,
          "quantity": entry.value,
          "productPrice": entry.key.productPrice,
          "category": entry.key.category,
          "imagePath": entry.key.imagePath,
        };
      }).toList();
      bool isSuccess = await ApiProvider().putData(
        'carts',
        {
          "userId": userId,
          "items": cartData,
          "updatedAt": DateTime.now().toIso8601String(),
        },
        docId: userId,
      );
      Get.back();
      if (isSuccess) {
        showCustomSnackBar("${product.productName} added to the cart!",
            isError: false);
      } else {
        throw Exception("Failed to update cart in Firebase.");
      }
    } catch (e) {
      showCustomSnackBar("Failed to update cart: $e!", isError: true);
    }
  }

  int get totalItemsInCart =>
      cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  @override
  void onInit() {
    getSharedData();
    fetchProducts();
    super.onInit();
  }
}
