import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/resources/dimensions.dart';

class LoginTextField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final TextInputType keyBoardType;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData icon;
  final Widget suffixIcon;
  final bool isObscure;

  const LoginTextField({
    super.key,
    required this.keyBoardType,
    this.textInputAction,
    this.controller,
    this.onTap,
    this.onChanged,
    this.validator,
    this.hintText,
    required this.icon,
    this.suffixIcon = const SizedBox(),
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsets.only(left: mobilePadding,top: mobilePadding,right: mobilePadding),
      child: Column(children: [
        Row(
          children: [
            Icon(
              icon,
              size: 17.w,
            ),
            SizedBox(width: mobilePadding),
            Expanded(
              child: TextFormField(
                textInputAction: textInputAction,
                keyboardType: keyBoardType,
                // style: interMedBlack17,
                onChanged: onChanged,
                onTap: onTap,
                controller: controller,
                validator: validator,
                obscureText: isObscure,
                textAlign: TextAlign.start,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: hintText,
                  isDense: true,
                  // hintStyle: interRegBlack15,
                  // contentPadding:
                  // EdgeInsets.symmetric(vertical: 16.w),
                ),
              ),
            ),
            suffixIcon
          ],
        ),
        SizedBox(
          height: 15.w,
        ),
        const Divider(color: borderColor, height: 2, thickness: 1),
      ]),
    );
  }
}

class InputTextField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final TextInputType? keyBoardType;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onEditCompleted;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  // final List<TextInputFormatter>? inputFormatter;
  final String? hintText;
  final bool? labelBold;
  final int? maxLine;
  final bool readOnly;
  final String title;
  final Widget? prefixIcon;
  final bool? isDense;

  const InputTextField(
      {super.key,
      this.keyBoardType,
      this.textInputAction,
      this.controller,
      this.onTap,
      // this.inputFormatter,
      this.onChanged,
      this.validator,
      this.hintText,
      required this.title,
      this.maxLine,
      this.isDense = true,
      this.readOnly = false,
      this.onEditCompleted,
      this.labelBold = false,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(8.w)),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
              child: TextFormField(
                  textInputAction: textInputAction,
                  keyboardType: keyBoardType,
                  // style: calibriBoldBlack17,
                  onChanged: onChanged,
                  onTap: onTap,
                  onEditingComplete: onEditCompleted,
                  readOnly: readOnly,
                  maxLines: maxLine,
                  controller: controller,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                      prefixIcon: prefixIcon,
                      border: InputBorder.none,
                      hintText: title,
                      isDense: isDense,
                      // hintStyle: labelBold == true
                      //     ? calibriBoldBlack17
                      //     : calibriRegBlack15.copyWith(color: colorTextGrey),

                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,

                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      focusedErrorBorder: InputBorder.none))),
        ),
        SizedBox(height: mobilePadding)
      ],
    );
  }
}
