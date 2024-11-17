import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/home_dashbord_controller.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/screens/home/widgets/bottom_bar_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Ensure you're using this package for responsive design

class HomeDashBoard extends StatelessWidget {
  HomeDashBoard({super.key});

  final HomeDashbordController dashboardController = Get.put(HomeDashbordController()); // Renamed for consistency

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Obx(() {
        return dashboardController.getDashboardWidget() ?? SizedBox.shrink(); // Fallback to an empty widget
      }),
      bottomNavigationBar: Container(
        height: 80.w,
        decoration: const BoxDecoration(color: colorMediumGrey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomBarItemWidget(index: 0, selectedIcon: Icons.home, title: 'Home'),
            BottomBarItemWidget(index: 1, selectedIcon: Icons.shopping_cart, title: 'Cart'),
            BottomBarItemWidget(index: 2, selectedIcon: Icons.person, title: 'Profile'),
          ],
        ),
      ),
    );
  }
}
