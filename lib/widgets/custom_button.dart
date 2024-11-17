import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ease/resources/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      width: 320.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        // boxShadow: const [boxShadow],
        // image: const DecorationImage(
        //     image: AssetImage(imgButtonBg),
        //     fit: BoxFit.fitHeight,
        //     alignment: Alignment.topRight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(title,
          style: TextStyle(
            color: colorWhite,
            fontSize: 16.sp,
          )),
    );
  }
}
