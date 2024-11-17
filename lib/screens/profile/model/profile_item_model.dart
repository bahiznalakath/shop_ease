import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ProfileItemModel {
  final IconData icon;
  final String title;
  final bool isVisible;
  final Callback onTap;

  ProfileItemModel(
      {required this.icon,
        required this.title,
        required this.onTap,
        this.isVisible = true});
}
