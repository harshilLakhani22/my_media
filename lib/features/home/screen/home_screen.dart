import 'package:coonch/api.dart';
import 'package:coonch/features/home/controllers/home_controller.dart';
import 'package:coonch/features/home/models/audio_model.dart';
import 'package:coonch/features/home/models/post_data_model.dart';
import 'package:coonch/features/home/models/text_model.dart';
import 'package:coonch/features/home/models/video_model.dart';
import 'package:coonch/features/home/widgets/audio_content_home.dart';
import 'package:coonch/features/home/widgets/choice_selection_home.dart';
import 'package:coonch/features/home/widgets/text_content_home.dart';
import 'package:coonch/features/home/widgets/video_content_home.dart';
import 'package:coonch/features/search/screen/search_user_profile_screen.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>()
    ..getAllPostData();
  final ScrollController _scrollController = ScrollController();

  HomeScreen({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (homeController.hasMore && !homeController.isLoading) {
          homeController.getAllPostData(); // Load next page
        }
      }
    });
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.softGrey,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(MSizes.smmd),
          child: Column(
            children: [
              /// Story
              SizedBox(
                height: 200, // Set the height to 200 pixels
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 160,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      MSizes.borderRadiusMd),
                                  child: Image.asset(MImages.imgMyStory),
                                  // child: SvgPicture.asset(MImages.imgMyStatus),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: (100 - 32) / 2,
                                right: (100 - 32) / 2,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.white,
                                        // width: 2,
                                      ),
                                    ),
                                    // child: SvgPicture.asset(MImages.imgMyStatusProfile)
                                    child:
                                        Image.asset(MImages.imgMyStatusProfile),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Text("data"),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// Choice Selection
              ChoiceSelectionHome(homeController: homeController),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Further body
              Obx(
                () => homeController.postDataModelList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeController.postDataModelList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index ==
                              homeController.postDataModelList.length) {
                            return homeController.hasMore
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const Center(child: Text("No more posts"));
                          }
                          PostDataModel postDataModel =
                              homeController.postDataModelList[index];
                          return GestureDetector(
                            onTap: () async {
                              String searchedUserId =
                                  postDataModel.creatorId ?? "";

                              bool isFollowing =
                                  await homeController.checkIfFollow(
                                      searchedUserId: searchedUserId);

                              debugPrint("Is following: $isFollowing");

                              Future.delayed(const Duration(seconds: 1), (){
                                Get.to(SearchUserProfileScreen(
                                  searchedUserId: searchedUserId,
                                  following: isFollowing,
                                  subscription: "subscription", /// Change
                                ));
                              });
                            },
                            child: postDataModel.contentType == "audio"
                                ? AudioContentHome(
                                    audioModel: AudioModel(
                                        profilePicUrl:
                                            "${APIConstants.strProfilePicBaseUrl}${postDataModel.profilePic}",
                                        userName: postDataModel.username ?? '',
                                        userCategory:
                                            postDataModel.category ?? '',
                                        audioUrl:
                                            '${APIConstants.strAudiosBaseUrl}${postDataModel.audioPath}',
                                        likesNo: 897,
                                        commentNo: 231,
                                        description:
                                            postDataModel.description ?? ''),
                                  )
                                : postDataModel.contentType == "video"
                                    ? VideoContentHome(
                                        videoModel: VideoModel(
                                            commentNo: 425,
                                            likesNo: 75,
                                            profilePicUrl:
                                                "${APIConstants.strProfilePicBaseUrl}${postDataModel.profilePic}",
                                            userCategory:
                                                postDataModel.category ?? '',
                                            userName:
                                                postDataModel.username ?? '',
                                            thumbnailUrl:
                                                '${APIConstants.strVideosBaseUrl}${postDataModel.thumbnailPath}',
                                            videoUrl:
                                                '${APIConstants.strVideosBaseUrl}${postDataModel.videoPath}',
                                            description:
                                                postDataModel.description ??
                                                    ''),
                                      )
                                    : TextContentHome(
                                        textModel: TextModel(
                                          profilePicUrl:
                                              "${APIConstants.strProfilePicBaseUrl}${postDataModel.profilePic}",
                                          userName:
                                              postDataModel.username ?? '',
                                          userCategory:
                                              postDataModel.category ?? '',
                                          textDescription:
                                              postDataModel.textContent ?? '',
                                          likesNo: 90,
                                          commentNo: 12,
                                        ),
                                      ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
