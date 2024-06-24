import 'dart:async';
import 'dart:io';

import 'package:coonch/common/widgets/profile_data_row_free.dart';
import 'package:coonch/common/widgets/profile_data_row_paid.dart';
import 'package:coonch/features/home/widgets/description_with_changeable_height_home.dart';
import 'package:coonch/features/search/model/search_user_profile_result.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class AudioContentSearch extends StatefulWidget {
  const AudioContentSearch({
    super.key,
    required this.audioModel,
    required this.isFree,
  });

  final Audio audioModel;
  final bool isFree;

  @override
  State<AudioContentSearch> createState() => _AudioContentSearchState();
}

class _AudioContentSearchState extends State<AudioContentSearch> {
  late AudioPlayer _audioPlayer;
  late Duration _playPosition;
  late Duration _audioDuration;
  bool _isPlaying = false;
  String? path;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _getDir();
    _audioPlayer = AudioPlayer();
    _playPosition = Duration.zero;
    _audioDuration = Duration.zero;

    _initAudio();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
  }

  Future<void> _initAudio() async {
    debugPrint("_initAudio=======>${widget.audioModel.audioPath}");
    AudioSource audioSource =
        AudioSource.uri(Uri.parse(widget.audioModel.audioPath ?? ""));

    await _audioPlayer.setAudioSource(audioSource);

    _audioPlayer.playerStateStream.listen((state) {
      if (context.mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });

    _audioPlayer.positionStream.listen((position) {
      if (context.mounted) {
        setState(() {
          _playPosition = position;
        });
      }
    });

    _audioPlayer.durationStream.listen((duration) {
      if (context.mounted) {
        setState(() {
          _audioDuration = duration ?? Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    if (context.mounted) {
      _audioPlayer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Profile Data Row
        if (widget.isFree)
          ProfileDataRowFree(
            profileUrl: widget.audioModel.profilePic,
            username: widget.audioModel.username,
            userCategory: widget.audioModel.category,
          )
        else
          ProfileDataRowPaid(
            profileUrl: widget.audioModel.profilePic,
            username: widget.audioModel.username,
            userCategory: widget.audioModel.category,
          ),

        /// Audio
        PolygonWaveform(
          samples: const [],
          height: 50,
          width: 50,
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              /// Button
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    _isPlaying ? _audioPlayer.pause() : _audioPlayer.play();
                  },
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
              ),

              /// Slider
              Expanded(
                flex: 9,
                child: Slider(
                  min: 0,
                  max: _audioDuration.inSeconds.toDouble(),
                  value: _playPosition.inSeconds.toDouble(),
                  onChanged: (value) {
                    final position = Duration(seconds: value.toInt());
                    _audioPlayer.seek(position);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: MSizes.sm),

        /// Description
        DescriptionWithChangeableHeightHome(model: widget.audioModel),
        const SizedBox(height: MSizes.sm),
      ],
    );
  }
}
