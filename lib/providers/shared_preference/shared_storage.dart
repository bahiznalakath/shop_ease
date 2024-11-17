import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_ease/resources/constants.dart';
import 'package:shop_ease/screens/login_screen.dart';


class SharedStorage {
  void setSharedString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void setLoginStatus(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void logoutUser() async {
    removeSharedData();
    Get.offAll(() => LoginScreen());

    // Get.back();
    // showLoaderDialog();
    // try {
    //   LogoutService.clearPushToken().then((value) {
    //     Get.back();
    //     removeSharedData();
    //     Get.offAll(() => LoginScreen());
    //   });
    // } finally {}
  }

  getSharedData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.get(key);
    return data;
  }

  void removeSharedData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(AppConstants.userName);
    prefs.remove(AppConstants.userType);

  }



}
