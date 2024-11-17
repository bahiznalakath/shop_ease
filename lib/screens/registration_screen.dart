import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/registeration_controller.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/resources/dimensions.dart';
import 'package:shop_ease/widgets/app_background_widget.dart';
import 'package:shop_ease/widgets/custom_app_bar.dart';
import 'package:shop_ease/widgets/custom_button.dart';
import 'package:shop_ease/widgets/input_textfield.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const CustomAppBar(
        title: "Registration or Sign Up",
      ),
      body: AppBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: mobilePadding),
            child: Column(
              children: [
                kHeight10,
                InputTextField(
                  title: "Name",
                  controller: controller.nameController,
                ),
                kHeight10,
                InputTextField(
                  title: "Email",
                  controller: controller.emailController,
                  keyBoardType: TextInputType.emailAddress,
                ),
                kHeight10,
                Obx(() {
                  return LoginTextField(
                    isObscure: controller.isPasswordVisible.value,
                    hintText: "Password",
                    controller: controller.passwordController,
                    suffixIcon: InkWell(
                        onTap: () =>
                        controller.isPasswordVisible.value =
                        !controller.isPasswordVisible.value,
                        child: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: bottomIconColor,
                          size: 19.w,
                        )),
                    keyBoardType: TextInputType.text,
                    icon: Icons.password,
                    // obscureText: true, // Ensure passwords are obscured
                  );
                }),
                // InputTextField(
                //   title: "Password",
                //   controller: controller.passwordController,
                //   // obscureText: true, // Ensure passwords are obscured
                // ),
                kHeight10,
                Obx(() {
                  return LoginTextField(
                    isObscure: controller.isPasswordVisible.value,
                    hintText: "Confirm Password",
                    controller: controller.confirmPasswordController,
                    suffixIcon: InkWell(
                        onTap: () =>
                        controller.isPasswordVisible.value =
                        !controller.isPasswordVisible.value,
                        child: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: bottomIconColor,
                          size: 19.w,
                        )),
                    keyBoardType: TextInputType.text,
                    icon: Icons.password,
                    // obscureText: true, // Ensure passwords are obscured
                  );
                }),
                // InputTextField(
                //   title: "Confirm Password",
                //   controller: controller.confirmPasswordController,
                //   // obscureText: true,
                // ),
                kHeight30,
                InkWell(
                    onTap: () {
                      controller.registerUser();
                    },
                    child: const CustomButton(
                      title: 'Sign Up',
                    )),
                kHeight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
