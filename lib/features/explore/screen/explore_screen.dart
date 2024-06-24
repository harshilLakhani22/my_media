import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/features/explore/controllers/explore_controller.dart';
import 'package:coonch/features/explore/widgets/explore_categories_option.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final ExploreController exploreController = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: SizedBox(
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                const Text(
                  "Explore Categories",
                  style: TextStyle(
                      fontSize: MSizes.fontSizeTitleMd,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: MSizes.spaceBtwItems),

                /// Sub-Title
                const Text(
                  "Discover a wide range of content across different categories to suit your interests and preferences.",
                  style: TextStyle(
                    fontSize: MSizes.fontSizeMd,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwItems),

                /// Categories
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: exploreController.categoriesIcons.length,
                    itemBuilder: (context, index) {
                      return ExploreCategoriesOption(
                        icon: exploreController.categoriesIcons[index],
                        title: exploreController.categoriesNames[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: MSizes.spaceBtwInputFields),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CommonElevatedButton(
        onPressed: () {},
        title: "View",
      ),
    );
  }
}
