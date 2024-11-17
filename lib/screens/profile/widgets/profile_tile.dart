import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:shop_ease/resources/colors.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Callback onTap;

  ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              icon,size: 20.w,
              // height: 24.w,
              color: colorMediumGrey,
            ),
            title: Text(title,
                style: TextStyle(
                    color: colorMediumGrey,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400)),
          ),
          const Divider(color: colorMediumGrey, height: 2),
        ],
      ),
    );
  }
}
