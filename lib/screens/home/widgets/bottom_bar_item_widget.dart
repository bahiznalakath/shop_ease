import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/home_dashbord_controller.dart';
import 'package:shop_ease/resources/colors.dart';

class BottomBarItemWidget extends StatelessWidget {

  final IconData selectedIcon;
  final String title;
  final int index;

  BottomBarItemWidget(
      {super.key,
      required this.index,
      required this.selectedIcon,

      required this.title});

  final HomeDashbordController bottomBarController =
      Get.put(HomeDashbordController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () => bottomBarController.changeTabIndex(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(selectedIcon,size: 26.w,
                // width: 26.w,
                // height: 26.w,
                color: bottomBarController.pageIndex.value == index
                    ? primaryColor
                    : colorWhite),
            SizedBox(height: 7.w),
            Text(title,
                style: TextStyle(
                    color: bottomBarController.pageIndex.value == index
                        ? primaryColor
                        : colorWhite,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w200))
          ],
        ),
      );
    });
  }
}
