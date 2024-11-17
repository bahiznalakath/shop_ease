import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_ease/model/category_model.dart';
import 'package:shop_ease/providers/api_provider.dart';
import 'package:shop_ease/widgets/custom_snackbar.dart';
import 'package:shop_ease/widgets/show_loader_dialog.dart';

class AddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  var selectedCategory = ''.obs;
  var productImagePath = ''.obs;
  var isLoading = false.obs;
  final List<Category> categories = [
    Category(id: '1', name: 'Electronics', codeNo: 'C001'),
    Category(id: '2', name: 'Fashion', codeNo: 'C002'),
    Category(id: '3', name: 'Groceries', codeNo: 'C003'),
    Category(id: '4', name: 'Books', codeNo: 'C004'),
    Category(id: '5', name: 'Toys', codeNo: 'C005'),
  ];

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImagePath.value = pickedFile.path;
    } else {
      showCustomSnackBar('No image selected.', isError: true);
    }
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) {
      showCustomSnackBar('Please fill in all required fields.', isError: true);
    } else if (productImagePath.value.isEmpty) {
      showCustomSnackBar('Please upload a product image.', isError: true);
    } else if (selectedCategory.value.isEmpty) {
      showCustomSnackBar('Please select a category.', isError: true);
    } else {
      isLoading.value = true;
      showLoaderDialog();
      try {
        isLoading.value = false;
        final productData = {
          'productCode': productCodeController.text.trim(),
          'productName': productNameController.text.trim(),
          'productDescription': productDescriptionController.text.trim(),
          'productPrice':
              double.tryParse(productPriceController.text.trim()) ?? 0.0,
          'category': selectedCategory.value,
          'imagePath': productImagePath.value,
          'timestamp': DateTime.now().toIso8601String(),
        };
        final success = await ApiProvider().putData('products', productData);
        isLoading.value = false;
        Get.back();
        Get.back();
        if (success) {
          showCustomSnackBar('Product added successfully.', isError: false);
          clearForm();
        } else {
          showCustomSnackBar('Failed to add product. Try again.',
              isError: true);
        }
      } catch (e) {
        isLoading.value = false;
        showCustomSnackBar('An unexpected error occurred: $e', isError: true);
      }
    }
  }

  void clearForm() {
    productCodeController.clear();
    productNameController.clear();
    productDescriptionController.clear();
    productPriceController.clear();
    selectedCategory.value = '';
    productImagePath.value = '';
  }

  @override
  void onClose() {
    productCodeController.dispose();
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    super.onClose();
  }

  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }
}
