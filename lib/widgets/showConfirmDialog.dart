import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:shop_ease/resources/colors.dart';

void showConfirmDialog(String message, Callback onYesTapped) {
  showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message, style: TextStyle(color: colorTextBlack, fontSize: 17.sp,  fontWeight: FontWeight.w300)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.w))),
          actions: <Widget>[
            TextButton(
                onPressed: () => Get.back(),
                child: Text('No',
                    style: TextStyle(color: colorTextBlack, fontSize: 15.sp,  ) )),
            TextButton(
                onPressed: onYesTapped,
                child: Text('Yes',
                    style: TextStyle(color: primaryColor, fontSize: 15.sp,  ) )),
          ],
        );
      });
}
