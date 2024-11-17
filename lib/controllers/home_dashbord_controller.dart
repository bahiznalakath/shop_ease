import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_ease/screens/cart_screen.dart';
import 'package:shop_ease/screens/profile/profile_screen.dart';
import 'package:shop_ease/screens/home/user_home.dart';
import 'package:shop_ease/screens/registration_screen.dart';

class HomeDashbordController extends GetxController {
  var pageIndex = 0.obs;
  String userRole = '';

  // Change tab index
  void changeTabIndex(int index) {
    pageIndex.value = index;
    update();
  }

  Widget? getDashboardWidget() {
    Widget? child;

    if (pageIndex.value == 0) {
      child = UserHome();
    } else if (pageIndex.value == 1) {
      child =   CartScreen();
    } else {
      child = ProfileScreen();
    }

    return child;
  }
}
