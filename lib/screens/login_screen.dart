import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/auth_controller.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/resources/dimensions.dart';
import 'package:shop_ease/screens/registration_screen.dart';
import 'package:shop_ease/widgets/custom_button.dart';
import 'package:shop_ease/widgets/input_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: mobilePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.w,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person,
                  size: 65.w,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                " Welcome to  \n  Shop Ease ",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              kHeight20,
              LoginTextField(
                hintText: "Email",
                controller: controller.emailController.value,
                keyBoardType: TextInputType.name,
                icon: Icons.mail,
              ),
              kHeight10,
              Obx(() {
                return LoginTextField(
                  isObscure: controller.isPasswordVisible.value,
                  hintText: "Password",
                  controller: controller.passwordController.value,
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
              kHeight30,
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  :
              InkWell(
                  onTap:controller.loginUser,
                  child: const CustomButton(
                    title: 'Login',
                  )),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RegistrationScreen());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
