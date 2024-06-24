import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {

  const VideoPlayerScreen({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer(widget.videoUrl);
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
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Center(
        child: (chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized)
            ? Chewie(controller: chewieController!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}
