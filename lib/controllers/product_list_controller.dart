import 'package:get/get.dart';
import 'package:shop_ease/model/product_model.dart';
import 'package:shop_ease/providers/api_provider.dart';


class ProductListController extends GetxController {
  var productList = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final data = await ApiProvider().getData('products');
      if (data != null && data['documents'] != null) {
        productList.value = (data['documents'] as List<dynamic>)
            .map((doc) => Product.fromFirestore(doc, doc['id']))
            .toList();
      } else {
        productList.clear();
        Get.snackbar('Info', 'No products found.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      bool success = await ApiProvider().deleteData('products', productId);
      if (success) {
        fetchProducts();
        // productList.removeWhere((product) => product.id == productId);
        Get.snackbar('Success', 'Product deleted successfully.');
      } else {
        Get.snackbar('Error', 'Failed to delete the product.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while deleting the product.');
    }
  }
}
