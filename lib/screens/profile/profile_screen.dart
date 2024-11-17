import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/profile_controller.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/resources/dimensions.dart';
import 'package:shop_ease/screens/profile/widgets/profile_tile.dart';
import 'package:shop_ease/widgets/app_background_widget.dart';
import 'package:shop_ease/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const CustomAppBar(
        title: "Profile",
        isBack: false,
      ),
      body: AppBackground(
        child: ListView(
          padding: EdgeInsets.all(mobilePadding),
          children: [
            ListView.separated(
              shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var item = controller.profileList[index];
                return ProfileTile(
                  icon: item.icon,
                  title: item.title,
                  onTap: item.onTap, // Ensures the provided callback is used
                );
              },
              separatorBuilder: (BuildContext context, int index) => kHeight,

              itemCount: controller.profileList.length,
            ),
          ],
        ),
      ),
    );
  }
}
