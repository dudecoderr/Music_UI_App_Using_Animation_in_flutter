import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app_flutter_ui/constant/color_constant.dart';

import '../../constant/common_container.dart';
import '../sub_screen.dart';

class PlayingControls extends StatelessWidget {
  final bool? isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  PlayingControls({
  this.isPlaying = true,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.onStop,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w,right: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(
            width: 12.w,
          ),

          InkWell(onTap: onPlay,
            child: Icon(
                isPlaying == true
                  ? Icons.pause
                  : Icons.play_arrow,
             color: kWhiteColor,size: 45.sp
            ),
          ),
      ]
      ),
    );
  }
}
