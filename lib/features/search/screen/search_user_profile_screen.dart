import 'package:coonch/api.dart';
import 'package:coonch/common/widgets/profile_data_row_free.dart';
import 'package:coonch/common/widgets/profile_data_row_paid.dart';
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/features/profile/widgets/profile_elevated_button.dart';
import 'package:coonch/features/search/controllers/search_screen_controller.dart';
import 'package:coonch/features/search/model/search_user_profile_result.dart';
import 'package:coonch/features/search/widgets/audio_content_search_screen.dart';
import 'package:coonch/features/search/widgets/search_profile_video_free.dart';
import 'package:coonch/features/search/widgets/search_profile_video_paid.dart';
import 'package:coonch/features/search/widgets/search_user_profile_photo_row.dart';
import 'package:coonch/features/search/widgets/search_user_profile_statistics.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUserProfileScreen extends StatelessWidget {
  SearchUserProfileScreen({
    super.key,
    required this.searchedUserId,
    required this.following,
    required this.subscription,
  });

  final String searchedUserId;
  final bool following;
  final String subscription;
  final RxInt currIndex = 0.obs;
  final RxString selectedContentType = 'free'.obs;
  final RxBool isLoading = true.obs;

  void changeTab(int index) {
    currIndex.value = index;
  }

  void changeContentType(String contentType) {
    selectedContentType.value = contentType;
    Get.find<SearchScreenController>().searchUserProfileAPI(
      searchUserId: searchedUserId,
      moneyType: contentType,
      callback2: () {
        isLoading.value = true;
      },
      callback3: () {
        isLoading.value = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>()
      ..callGetProfile(otherUserId: searchedUserId);

    final SearchScreenController searchScreenController =
        Get.find<SearchScreenController>()
          ..searchUserProfileAPI(
            searchUserId: searchedUserId,
            callback2: () {
              isLoading.value = true;
            },
            callback3: () {
              isLoading.value = false;
            },
          );

    return Scaffold(
      backgroundColor: MColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (searchScreenController.searchedUser?.value == null) {
            return const Center(child: Text('User not found'));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(MSizes.md),
              child: Column(
                children: [
                  /// Profile Photo row
                  SearchUserProfilePhotoRow(
                    profilePicUrl:
                        "${APIConstants.strProfilePicBaseUrl}${profileController.otherUser!.value.profilePic}" ??
                            MTexts.strDummyProfileUrl,
                    userName: profileController.otherUser!.value.username ??
                        "Null Username",
                    bio: profileController.otherUser!.value.bio ?? "Null Bio",
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),

                  /// User Statistics row
                  SearchUserProfileStatistics(
                      profileController: profileController),
                  const SizedBox(height: MSizes.spaceBtwItems),

                  /// Follow & Subscription
                  Row(
                    children: [
                      Expanded(
                        child: ProfileElevatedButton(
                          onPressed: () {},
                          title:
                              following ? MTexts.strUnFollow : MTexts.strFollow,
                        ),
                      ),
                      const SizedBox(width: MSizes.sm),
                      Expanded(
                        child: ProfileElevatedButton(
                          onPressed: () {},
                          title: subscription,
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
                              borderRadius:
                                  BorderRadius.circular(MSizes.borderRadiusLg),
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
                              borderRadius:
                                  BorderRadius.circular(MSizes.borderRadiusLg),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        searchScreenController.choiceItem.map((currChoice) {
                      bool isSelected = currIndex.value == currChoice['value'];
                      return GestureDetector(
                        onTap: () => changeTab(currChoice['value']),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 100,
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
                              color:
                                  isSelected ? MColors.white : MColors.darkGrey,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),

                  () {
                    /// Showing Video
                    if (currIndex.value == 0) {
                      if (searchScreenController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final videos = searchScreenController
                          .userProfileResult.value!.videos;
                      if (videos.isEmpty) {
                        return const Center(child: Text('No videos uploaded'));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          print('Length of videos list: ${videos.length}');
                          print('Accessing index: $index');
                          if (index >= videos.length) {
                            return const Center(
                              child: Text('Invalid index'),
                            );
                          }
                          final video = videos[index];
                          String videoUrl =
                              APIConstants.strVideosBaseUrl + video.videoPath;
                          String thumbnailUrl = APIConstants.strVideosBaseUrl +
                              video.thumbnailPath;
                          String username = video.username;
                          String userCategory = video.category;
                          String contentId = video.contentId;
                          String userProfilePic = "${APIConstants.strProfilePicBaseUrl}${video.profilePic}";

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
                              : SearchProfileVideoPaid(
                                  profileUrl: userProfilePic,
                                  searchScreenController:
                                      searchScreenController,
                                  thumbnailUrl: thumbnailUrl,
                                  username: username,
                                  userCategory: userCategory,
                                  videoUrl: videoUrl,
                                  contentId: contentId,
                                  planType: subscription,
                                  creatorId: searchedUserId,
                                );
                        },
                      );
                    }

                    /// Showing Audio
                    else if (currIndex.value == 1) {
                      if (searchScreenController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (searchScreenController
                              .userProfileResult.value?.audios.isEmpty ??
                          true) {
                        return const Center(
                          child: Text('No audios uploaded'),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchScreenController
                            .userProfileResult.value!.audios.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: MSizes.smmd),
                              AudioContentSearch(
                                audioModel: Audio(
                                  id: searchScreenController.userProfileResult
                                      .value!.audios[index].id,
                                  contentId: searchScreenController
                                      .userProfileResult
                                      .value!
                                      .audios[index]
                                      .contentId,
                                  moneyType: searchScreenController
                                      .userProfileResult
                                      .value!
                                      .audios[index]
                                      .moneyType,
                                  category: searchScreenController
                                      .userProfileResult
                                      .value!
                                      .audios[index]
                                      .category,
                                  uploadedBy: searchScreenController
                                      .userProfileResult
                                      .value!
                                      .audios[index]
                                      .uploadedBy,
                                  uploadedAt: searchScreenController
                                      .userProfileResult
                                      .value!
                                      .audios[index]
                                      .uploadedAt,
                                  username: searchScreenController
                                      .userProfileResult
                                      .value!
                                      .audios[index]
                                      .username,
                                  profilePic: searchScreenController
                                      .userProfileResult
                                      .value!
                                      .audios[index]
                                      .profilePic,
                                ),
                                isFree: (selectedContentType.value == 'free')
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
                      if (searchScreenController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (searchScreenController
                              .userProfileResult.value?.text.isEmpty ??
                          true) {
                        return const Center(
                          child: Text('No text uploaded'),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchScreenController
                            .userProfileResult.value!.text.length,
                        itemBuilder: (context, index) {
                          String username = searchScreenController
                              .userProfileResult.value!.text[index].username;
                          String userCategory = searchScreenController
                              .userProfileResult.value!.text[index].category;
                          String textContent = searchScreenController
                                  .userProfileResult
                                  .value!
                                  .text[index]
                                  .textContent ??
                              "Null Text Content";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: MSizes.smmd),
                              selectedContentType.value == 'free'
                                  ? ProfileDataRowFree(
                                      profileUrl: MImages.imgMyStatusProfile2,
                                      username: username,
                                      userCategory: userCategory,
                                    )
                                  : ProfileDataRowPaid(
                                      profileUrl: MImages.imgMyStatusProfile2,
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
                  }()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
