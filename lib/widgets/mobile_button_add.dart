import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ease/resources/colors.dart';


class MobileButtonAdd extends StatelessWidget {
  final VoidCallback? onTap;

  const MobileButtonAdd({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: primaryColor,

          borderRadius: BorderRadius.circular(10.w)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.w),
          child: Text(
            "Add",
            style: TextStyle(
              fontSize: 15.w,
              color: Colors.white,
            ),

          ),
        ),
      ),
    );
  }
}
