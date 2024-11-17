import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shop_ease/model/user_model.dart';
import 'package:shop_ease/providers/api_provider.dart';
import 'package:shop_ease/providers/shared_preference/shared_storage.dart';
import 'package:shop_ease/resources/constants.dart';
import 'package:shop_ease/screens/home/admin_home.dart';
import 'package:shop_ease/widgets/custom_snackbar.dart';
import 'package:shop_ease/widgets/show_loader_dialog.dart';
import '../screens/home/home_dashbord.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  var isPasswordVisible = true.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginUser() async {
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();
    if (email.isEmpty) {
      showCustomSnackBar("Email field cannot be empty!", isError: true);
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      showCustomSnackBar("Please enter a valid email address.", isError: true);
    } else if (password.isEmpty) {
      showCustomSnackBar("Password field cannot be empty!", isError: true);
    } else if (password.length < 8) {
      showCustomSnackBar("Password must be at least 8 characters long.", isError: true);
    } else {
      showLoaderDialog();
      isLoading.value = true;
      try {
        String? loginResult = await ApiProvider().loginUser(email, password);
        String userId = FirebaseAuth.instance.currentUser!.uid;
        Map<String, dynamic>? userData =
        await ApiProvider().getData('users', docId: userId);
        isLoading.value = false;
        Get.back();
        if (loginResult == null) {
          UserModel user = UserModel.fromMap(userData!);
          SharedStorage().setSharedString(
              AppConstants.userName, user.name ?? '');
          SharedStorage().setSharedString(
              AppConstants.userType, user.userType ?? '');
          if (user.userType == "admin") {
            Get.offAll(() => AdminHome());
          } else {
            Get.offAll(() => HomeDashBoard());
          }
        } else {
          String errorMessage;
          if (loginResult == 'wrong-password') {
            errorMessage = "Incorrect password. Please try again.";
          } else if (loginResult == 'user-not-found') {
            errorMessage = "User not found. Please check your email.";
          } else {
            errorMessage = "An unexpected error occurred. Please try again.";
          }
          showCustomSnackBar(errorMessage, isError: true);
        }
      } catch (e) {
        isLoading.value = false;
        showCustomSnackBar("An unexpected error occurred. Please try again.",
            isError: true);
      }
    }
  }

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }
}
