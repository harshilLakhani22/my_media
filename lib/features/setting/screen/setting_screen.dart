import 'package:coonch/features/auth/screens/login_screen.dart';
import 'package:coonch/features/setting/controllers/setting_controller.dart';
import 'package:coonch/features/setting/screen/subscription_screen.dart';
import 'package:coonch/features/setting/widgets/setting_list_tile.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text(
          MTexts.strSettings,
          style: TextStyle(
            fontSize: MSizes.fontSizeLg,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Primary Setting
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(MSizes.borderRadiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: MSizes.sm),
                    SettingListTile(
                      onTap: () {},
                      title: MTexts.strAccount,
                      leadingIcon: MIcons.iconProfileSetting,
                    ),
                    SettingListTile(
                      onTap: () {
                        Get.to(SubscriptionScreen());
                      },
                      title: MTexts.strSubscription,
                      leadingIcon: MIcons.iconSubscription,
                    ),
                    SettingListTile(
                      leadingIcon: MIcons.iconMonetization,
                      title: MTexts.strMonetization,
                      onTap: () {},
                    ),
                    SettingListTile(
                      leadingIcon: MIcons.iconShareProfile,
                      title: MTexts.strShareProfile,
                      onTap: () {},
                    ),
                    SettingListTile(
                      leadingIcon: MIcons.iconPlayLists,
                      title: MTexts.strPlayLists,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Notification Setting
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      MTexts.strNotification,
                      style: TextStyle(
                        fontSize: MSizes.fontSizeMd,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: MSizes.sm),
                    ListTile(
                      leading: SvgPicture.asset(MIcons.iconNotification),
                      title: const Text(MTexts.strPopUpNotification),
                      trailing: Obx(() {
                        return Switch(
                          value: settingController.valueOfSwitch.value,
                          onChanged: (value) {
                            settingController.toggleSwitch(value);
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Rewards
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      MTexts.strRewards,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    ListTile(
                      leading: SvgPicture.asset(MIcons.iconNotification),
                      title: const Text(MTexts.strRewardPointAndCoupons),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Log Out
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    settingController.clearUserData();
                    Get.to(LoginScreen());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(MIcons.iconLogOut),
                      const SizedBox(width: 10.0),
                      const Text(MTexts.strLogOut),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
