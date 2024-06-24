import 'package:coonch/features/setting/controllers/setting_controller.dart';
import 'package:coonch/features/setting/screen/subscription_models_screen.dart';
import 'package:coonch/features/setting/screen/subscription_plans_screen.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key, this.creatorUserId});

  final String? creatorUserId;

  final SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text(
          MTexts.strSubscriptionPlan,
          style: TextStyle(
            fontSize: MSizes.fontSizeLg,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                // height: 50,
                padding: const EdgeInsets.symmetric(
                  vertical: MSizes.sm,
                  horizontal: MSizes.md,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MColors.buttonUnSelected.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(MSizes.cardRadiusLg)),
                width: double.maxFinite,
                child: TabBar(
                  indicator: BoxDecoration(
                    color: MColors.buttonPrimary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelColor: MColors.white,
                  unselectedLabelColor: MColors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "Plans"),
                    Tab(text: "Models"),
                  ],
                ),
              ),
               Expanded(
                child: TabBarView(
                  children: [
                    SubscriptionPlansScreen(creatorUserId: creatorUserId,),
                    const SubscriptionModelsScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
