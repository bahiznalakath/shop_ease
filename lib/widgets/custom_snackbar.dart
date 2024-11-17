import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ease/resources/colors.dart';

void showCustomSnackBar(String message, {bool isError = true, int timer = 3}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
      elevation: 2,
    ));
  }
}

void topCustomSnackbar(String message, String title,
    {bool isError = true, int timer = 3}) {
  if (message.isNotEmpty) {
    Get.snackbar(title, message,
        duration: Duration(seconds: timer),
        backgroundColor: isError ? Colors.red : Colors.green,
        colorText: colorWhite);
  }
}
