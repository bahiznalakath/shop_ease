import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../resources/colors.dart';

showLoaderDialog() {
  Widget alert = Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    // insetPadding: EdgeInsets.all(10),
    child: IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              // width: 100.w,
              padding: const EdgeInsets.all(5),
              child: const CircularProgressIndicator(color: primaryColor,)),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: Get.overlayContext!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
