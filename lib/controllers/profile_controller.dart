import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shop_ease/providers/api_provider.dart';
import 'package:shop_ease/providers/shared_preference/shared_storage.dart';
 import 'package:shop_ease/screens/login_screen.dart';
import 'package:shop_ease/screens/profile/model/profile_item_model.dart';
import 'package:shop_ease/widgets/custom_snackbar.dart';
import 'package:shop_ease/widgets/showConfirmDialog.dart';
import 'package:shop_ease/widgets/show_loader_dialog.dart';
import '../screens/cart_screen.dart';

class ProfileController extends GetxController {
  List<ProfileItemModel> profileList = [
    ProfileItemModel(
      icon: Icons.shopping_cart,
      title: "Cart  ",
      onTap: () => Get.to(()=>CartScreen()),
    ),
    ProfileItemModel(
      icon: Icons.logout,
      title: "Logout",
      onTap: () => showConfirmDialog(
        "Are you sure you want to log out?",
        () async {
          try {

            await ApiProvider().logoutUser();
            showLoaderDialog();
            SharedStorage().removeSharedData();
            showCustomSnackBar("Logged out successfully!", isError: false);
            Get.offAll(() => LoginScreen());
          } catch (e) {
            showCustomSnackBar(
              "An error occurred while logging out. Please try again.",
              isError: true,
            );
          }
        },
      ),
    ),
  ];
}
