
import 'package:coonch/features/home/controllers/home_controller.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChoiceSelectionHome extends StatelessWidget {
  const ChoiceSelectionHome({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: homeController.choiceItem
          .map((currChoice) => Obx(() {
        bool isSelected =
            homeController.currIndex == currChoice['value'];
        return GestureDetector(
          onTap: () {
            homeController.changeTab(currChoice['value']);
            homeController.getAllPostData(selectedCategory: currChoice['filter'], isRefresh: true);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: MSizes.sm),
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: 30,
            width: 76,
            decoration: BoxDecoration(
              color: isSelected
                  ? MColors.buttonPrimary
                  : MColors.white,
              borderRadius:
              BorderRadius.circular(MSizes.borderRadiusLg),
            ),
            child: Text(
              currChoice['name'],
              style: TextStyle(
                color: isSelected ? MColors.white : MColors.darkGrey,
              ),
            ),
          ),
        );
      }))
          .toList(),
    );
  }
}
