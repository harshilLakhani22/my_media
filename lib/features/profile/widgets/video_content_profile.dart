import 'package:chewie/chewie.dart';
import 'package:coonch/common/widgets/like_share_row.dart';
import 'package:coonch/features/home/models/video_model.dart';
import 'package:coonch/features/profile/controllers/profile_controller.dart';
import 'package:coonch/features/profile/widgets/description_with_changeable_height_profile.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoContentProfile extends StatefulWidget {
  const VideoContentProfile({
    super.key,
    required this.videoModel,
    required this.profileController,
  });

  final VideoModel videoModel;
  final ProfileController profileController;

  @override
  State<VideoContentProfile> createState() => _VideoContentProfileState();
}

class _VideoContentProfileState extends State<VideoContentProfile> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePlayer(widget.videoModel.videoUrl);
  }

  Future<void> initializePlayer(String url) async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.white,
        backgroundColor: Colors.yellow,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(
        // color: Colors.purple,
      ),
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Profile Data Row
        // ProfileDataRow(
        //   profileUrl: MImages.imgMyStatusProfile2,
        //   username: widget.videoModel.userName,
        //   userCategory: widget.videoModel.userCategory,
        // ),

        /// Video
        SizedBox(
          height: 200,
          child: Center(
            child: (chewieController != null &&
                chewieController!.videoPlayerController.value.isInitialized)
                ? Chewie(controller: chewieController!)
                : const CircularProgressIndicator(),
            // : Shimmer.fromColors(
            //     baseColor: Colors.grey.shade300,
            //     highlightColor: Colors.grey.shade100,
            //     child: Container(
            //       height: 200,
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //     ),
            //   ),
          ),
        ),
        const SizedBox(height: MSizes.sm),

        /// Like, Share & etc.
        LikeShareRow(
          commentNo: widget.videoModel.commentNo,
          likeNo: widget.videoModel.likesNo,
        ),
        const SizedBox(height: MSizes.sm),

        /// Description
        DescriptionWithChangeableHeightProfile(
          model: widget.videoModel,
          profileController: widget.profileController,
        ),
      ],
    );
  }
}
