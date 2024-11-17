import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/resources/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.isBack = true,
      this.centeredTitle = true,
      this.isBackFunction = false,
      this.actions,
      this.onTap,
      this.bottom});

  final String title;
  final bool isBack, isBackFunction;
  final bool centeredTitle;
  final List<Widget>? actions;
  final Function? onTap;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: colorWhite,
      // flexibleSpace: const Image(
      //   image: AssetImage(imgHomeAppBg),
      //   fit: BoxFit.cover,
      // ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: centeredTitle,
      title: Text(title,
          style: TextStyle(
              color: colorTextWhite,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500)),
      leading: isBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: colorWhite),
              onPressed: () => isBackFunction ? onTap!() : Get.back())
          : null,
      actions: actions,
      bottom: bottom,
    );
  }
}
