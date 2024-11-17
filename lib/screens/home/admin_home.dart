import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/providers/api_provider.dart';
import 'package:shop_ease/providers/shared_preference/shared_storage.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/resources/dimensions.dart';
import 'package:shop_ease/screens/add_product_screen.dart';
import 'package:shop_ease/screens/login_screen.dart';
import 'package:shop_ease/screens/product_list.dart';
import 'package:shop_ease/screens/profile/widgets/profile_tile.dart';
import 'package:shop_ease/widgets/app_background_widget.dart';
import 'package:shop_ease/widgets/custom_snackbar.dart';
import 'package:shop_ease/widgets/showConfirmDialog.dart';
import 'package:shop_ease/widgets/show_loader_dialog.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        foregroundColor: colorWhite,
        backgroundColor: primaryColor,
        elevation: 4,
        title: Text(
          "Admin Panel",
          style: TextStyle(
            color: colorTextWhite,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showConfirmDialog(
              "Are you sure you want to log out?",
              () async {
                try {
                  await ApiProvider().logoutUser();
                  showLoaderDialog();
                  SharedStorage().removeSharedData();
                  showCustomSnackBar("Logged out successfully!",
                      isError: false);
                  Get.offAll(() => LoginScreen());
                } catch (e) {
                  showCustomSnackBar(
                    "An error occurred while logging out. Please try again.",
                    isError: true,
                  );
                }
              },
            ),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: AppBackground(
        child: ListView(
          padding: EdgeInsets.all(mobilePadding),
          // Ensure mobilePadding is defined in Dimensions
          children: [
            ProfileTile(
              icon: Icons.add,
              title: "Add Product",
              onTap: () => Get.to(() =>
                  AddProductScreen()), // Use const constructor if possible
            ),
            ProfileTile(
              icon: Icons.production_quantity_limits,
              title: "Product List",
              onTap: () => Get.to(() =>
                    ProductListScreen()), // Use const constructor if possible
            ),
          ],
        ),
      ),
    );
  }
}
