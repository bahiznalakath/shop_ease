import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop_ease/providers/shared_preference/shared_storage.dart';
import 'package:shop_ease/resources/constants.dart';
import 'package:shop_ease/screens/home/admin_home.dart';
import 'package:shop_ease/screens/home/home_dashbord.dart';
import 'package:shop_ease/screens/login_screen.dart';
import 'package:shop_ease/screens/home/user_home.dart';

class SplashController extends GetxController {
  var userType = "".obs;

  @override
  void onInit() {
    getSharedData();
    navigate(); // TODO: implement onInit
    super.onInit();
  }

  getSharedData() async {
    userType.value = await SharedStorage().getSharedData(AppConstants.userName);
  }

  void navigate() async {
    await Future.delayed(Duration(seconds: 3)); // Simulate loading
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      if (userType.value == "admin") {
        Get.offAll(() => AdminHome());
      } else {
        Get.offAll(() => HomeDashBoard());
      }
    }
  }
}
