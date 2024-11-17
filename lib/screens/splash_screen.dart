import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/splash_controller.dart';
import 'package:shop_ease/resources/colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController myController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: primaryColor
          ,
        ),
      ),
    );
  }
}
