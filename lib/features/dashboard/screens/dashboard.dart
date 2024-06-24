import 'package:coonch/features/dashboard/controllers/dashboard_controller.dart';
import 'package:coonch/features/dashboard/widgets/floating_action_menu.dart';
import 'package:coonch/features/setting/screen/setting_screen.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final DashBoardController dashBoardController =
      Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              MImages.imgHomeAppMain,
              height: 34,
              width: 40,
            ),
          ),
          SvgPicture.asset(MImages.imgCoonchName)
        ]),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(SettingsScreen());
            },
            icon: SvgPicture.asset(MIcons.iconSetting),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(MIcons.iconFilter),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              MIcons.iconNotification,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return IndexedStack(
          index: dashBoardController.currentIndex.value,
          children: dashBoardController.screens,
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: MColors.buttonPrimary,
          unselectedItemColor: MColors.buttonUnSelected,
          onTap: dashBoardController.changeTabIndex,
          currentIndex: dashBoardController.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionMenu(),
    );
  }
}
