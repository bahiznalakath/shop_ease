import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ease/providers/api_provider.dart';
import 'package:shop_ease/screens/home/home_dashbord.dart';
import 'package:shop_ease/screens/home/user_home.dart';
import 'package:shop_ease/widgets/custom_snackbar.dart';
import 'package:shop_ease/widgets/show_loader_dialog.dart';

class RegistrationController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var isLoading = false.obs;
  var isPasswordVisible = true.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  Future<void> registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showCustomSnackBar("All fields are required!", isError: true);
      return;
    }
    if (password != confirmPassword) {
      showCustomSnackBar("Passwords do not match!", isError: true);
      return;
    }
    isLoading.value = true;
    showLoaderDialog();
    try {
      String? result = await ApiProvider().registerUser(name, email, password);
      print("----result--------------$result");
      if (result == null) {
        isLoading.value = false;
        Get.back();
        showCustomSnackBar("Registered successfully!!", isError: false);
        Get.offAll(() => HomeDashBoard());
      } else {
        showCustomSnackBar("Error!!$result,", isError: true);
      }
    } catch (e) {
      isLoading.value = false;
      showCustomSnackBar("An unexpected error occurred. Please try again.",
          isError: true);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
