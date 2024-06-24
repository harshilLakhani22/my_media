import 'package:coonch/api.dart';
import 'package:coonch/common/widgets/common_profile_photo_row.dart';
import 'package:coonch/common/widgets/profile_data_row_free.dart';
import 'package:coonch/common/widgets/profile_data_row_paid.dart';
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/features/profile/screen/edit_profile_screen.dart';
import 'package:coonch/features/profile/widgets/choice_selection_profile.dart';
import 'package:coonch/features/profile/widgets/current_user_profile_statistics.dart';
import 'package:coonch/features/profile/widgets/profile_elevated_button.dart';
import 'package:coonch/features/search/controllers/search_screen_controller.dart';
import 'package:coonch/features/search/model/search_user_profile_result.dart';
import 'package:coonch/features/search/widgets/audio_content_search_screen.dart';
import 'package:coonch/features/search/widgets/search_profile_video_free.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>()
    ..callGetProfile();


  final RxString selectedContentType = 'free'.obs;

  void changeContentType(String contentType) {
    selectedContentType.value = contentType;
    // Get.find<SearchScreenController>().searchUserProfileAPI(
    //   searchUserId: profileController.userDataModel?.value.userid ?? "",
    //   moneyType: contentType,
    // );
    profileController.searchOwnProfileAPI(
      searchUserId: profileController.userDataModel?.value.userid ?? "",
      moneyType: contentType,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String ownProfileId =
        profileController.userDataModel?.value.userid ?? "";

    profileController.searchOwnProfileAPI(searchUserId: ownProfileId);

    // final SearchScreenController searchScreenController =
    //     Get.find<SearchScreenController>()
    //       ..searchUserProfileAPI(searchUserId: ownProfileId);


    return Scaffold(
      backgroundColor: MColors.softGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.md),
          child: Obx(
            () {
              var userPScreen = profileController.userDataModel?.value;
              return userPScreen == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        /// Profile Photo row
                        CommonProfilePhotoRow(
                          imageString:
                              "${APIConstants.strProfilePicBaseUrl}${userPScreen.profilePic}",
                          username: userPScreen.username ?? 'Null Username',
                          bio: userPScreen.bio ?? 'Null Bio',
                        ),
                        const SizedBox(height: MSizes.spaceBtwItems),

                        /// User Statistics row
                        CurrentUserProfileStatistics(
                            profileController: profileController),
                        const SizedBox(height: MSizes.spaceBtwItems),

                        /// Edit Profile & Create Playlist
                        Row(
                          children: [
                            Expanded(
                              child: ProfileElevatedButton(
                                onPressed: () {
                                  Get.to(const EditProfileScreen());
                                },
                                title: MTexts.strEditProfile,
                                icon: Icons.mode_edit_outline_outlined,
                              ),
                            ),
                            const SizedBox(width: MSizes.sm),
                            Expanded(
                              child: ProfileElevatedButton(
                                onPressed: () {},
                                title: MTexts.strCreatePlayList,
                                icon: Icons.add,
                                isTransparent: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MSizes.spaceBtwItems),

                        /// Paid and Free Content Selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => changeContentType('free'),
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: selectedContentType.value == 'free'
                                        ? MColors.buttonPrimary
                                        : MColors.white,
                                    borderRadius: BorderRadius.circular(
                                        MSizes.borderRadiusLg),
                                  ),
                                  child: Text(
                                    'Free',
                                    style: TextStyle(
                                      color: selectedContentType.value == 'free'
                                          ? MColors.white
                                          : MColors.darkGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => changeContentType('paid'),
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: selectedContentType.value == 'paid'
                                        ? MColors.buttonPrimary
                                        : MColors.white,
                                    borderRadius: BorderRadius.circular(
                                        MSizes.borderRadiusLg),
                                  ),
                                  child: Text(
                                    'Paid',
                                    style: TextStyle(
                                      color: selectedContentType.value == 'paid'
                                          ? MColors.white
                                          : MColors.darkGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MSizes.spaceBtwItems),

                        /// Choice Selection
                        ChoiceSelectionProfile(
                            profileController: profileController),
                        const SizedBox(height: MSizes.spaceBtwItems),

                        Obx(
                          () {
                            /// Showing Video
                            if (profileController.currIndex.value == 0) {
                              if (profileController.isLoading.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (profileController.userProfileResult.value
                                      ?.videos.isEmpty ??
                                  true) {
                                return const Center(
                                  child: Text('No videos uploaded'),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: profileController
                                    .userProfileResult.value?.videos.length,
                                itemBuilder: (context, index) {
                                  String videoUrl =
                                      APIConstants.strVideosBaseUrl +
                                          profileController
                                              .userProfileResult
                                              .value!
                                              .videos[index]
                                              .videoPath;
                                  String thumbnailUrl =
                                      APIConstants.strVideosBaseUrl +
                                          profileController
                                              .userProfileResult
                                              .value!
                                              .videos[index]
                                              .thumbnailPath;
                                  String username = profileController
                                      .userProfileResult
                                      .value!
                                      .videos[index]
                                      .username;
                                  String userCategory = profileController
                                      .userProfileResult
                                      .value!
                                      .videos[index]
                                      .category;
                                  String userProfilePic =
                                      "${APIConstants.strProfilePicBaseUrl}${userPScreen.profilePic}";

                                  return selectedContentType.value == 'free'
                                      ? SearchProfileVideoFree(
                                          profileUrl: userProfilePic,
                                          // searchScreenController:
                                          //     searchScreenController,
                                          videoUrl: videoUrl,
                                          thumbnailUrl: thumbnailUrl,
                                          username: username,
                                          userCategory: userCategory,
                                        )
                                      : SearchProfileVideoFree(
                                          profileUrl: userProfilePic,
                                          // searchScreenController:
                                          //     searchScreenController,
                                          thumbnailUrl: thumbnailUrl,
                                          username: username,
                                          userCategory: userCategory,
                                          videoUrl: videoUrl,
                                        );
                                },
                              );
                            }

                            /// Showing Audio
                            else if (profileController.currIndex.value == 1) {
                              if (profileController.isLoading.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (profileController.userProfileResult.value
                                      ?.audios.isEmpty ??
                                  true) {
                                return const Center(
                                  child: Text('No audios uploaded'),
                                );
                              }
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: profileController
                                    .userProfileResult.value!.audios.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      const SizedBox(height: MSizes.smmd),
                                      AudioContentSearch(
                                        audioModel: Audio(
                                          id: profileController
                                              .userProfileResult
                                              .value!
                                              .audios[index]
                                              .id,
                                          contentId: profileController
                                              .userProfileResult
                                              .value!
                                              .audios[index]
                                              .contentId,
                                          moneyType: profileController
                                              .userProfileResult
                                              .value!
                                              .audios[index]
                                              .moneyType,
                                          category: profileController
                                              .userProfileResult
                                              .value!
                                              .audios[index]
                                              .category,
                                          uploadedBy: profileController
                                              .userProfileResult
                                              .value!
                                              .audios[index]
                                              .uploadedBy,
                                          uploadedAt: profileController
                                              .userProfileResult
                                              .value!
                                              .audios[index]
                                              .uploadedAt,
                                          username: profileController
                                              .userProfileResult
                                              .value!
                                              .audios[index]
                                              .username,
                                          profilePic:
                                              "${APIConstants.strProfilePicBaseUrl}${profileController.userProfileResult.value!.audios[index].profilePic}",
                                        ),
                                        isFree: (selectedContentType.value ==
                                                'free')
                                            ? true
                                            : false,
                                      ),
                                      const SizedBox(height: MSizes.sm),
                                    ],
                                  );
                                },
                              );
                            }

                            /// Showing Text
                            else {
                              if (profileController.isLoading.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (profileController
                                      .userProfileResult.value?.text.isEmpty ??
                                  true) {
                                return const Center(
                                  child: Text('No text uploaded'),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: profileController
                                    .userProfileResult.value!.text.length,
                                itemBuilder: (context, index) {
                                  String username = profileController
                                      .userProfileResult
                                      .value!
                                      .text[index]
                                      .username;
                                  String userCategory = profileController
                                      .userProfileResult
                                      .value!
                                      .text[index]
                                      .category;
                                  String textContent = profileController
                                          .userProfileResult
                                          .value!
                                          .text[index]
                                          .textContent ??
                                      "Null Text Content";
                                  String profilePic =
                                      "${APIConstants.strProfilePicBaseUrl}${profileController.userProfileResult.value?.text[index].profilePic}";

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: MSizes.smmd),
                                      selectedContentType.value == 'free'
                                          ? ProfileDataRowFree(
                                              profileUrl: profilePic,
                                              username: username,
                                              userCategory: userCategory,
                                            )
                                          : ProfileDataRowPaid(
                                              profileUrl: profilePic,
                                              username: username,
                                              userCategory: userCategory,
                                            ),
                                      Text(textContent),
                                      const SizedBox(height: MSizes.sm),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: kBottomNavigationBarHeight),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
