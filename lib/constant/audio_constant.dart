import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter_ui/constant/color_constant.dart';

RxBool playerVisible = false .obs;
List<Audio> playList = [];
AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.withId('0');
List<SongListModel> songListModel = [];
RxBool nextSong = true.obs;

class SongListModel {
  SongListModel({
    this.image, this.desc, this.title, this.photo, this.url, this.id,
  });

  final String? image;
  final String? desc;
  final String? title;
  final String? photo;
  final String? url;
  final String? id;
}

Widget slidablePanelHeader({required BuildContext context, required VoidCallback onTap}) {
  return Obx(() {
    return playerVisible.value
        ? Dismissible(
      key: const Key('key'),
      direction: DismissDirection.down,
      onDismissed: (val) {
        playerVisible.value = false;
        _assetsAudioPlayer.stop();
      },
      child: _assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
        return PlayerBuilder.current(
            player: _assetsAudioPlayer,
            builder: (context, value) {
              return GestureDetector(
                onTap: onTap,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:50.h,
                  color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        value.audio.audio.metas.title!
                                    ),
                                    SizedBox(height: 2.h),
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(value.audio.audio.metas.artist!,),
                                    ),
                                  ],
                                ),
                                PlayerBuilder.isPlaying(
                                  player: _assetsAudioPlayer,
                                  builder: (context, isPlaying) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _assetsAudioPlayer.playOrPause();
                                          },
                                          child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                                              color: kWhiteColor),
                                        ),
                                        Obx(() {
                                          nextSong.value;
                                          return IconButton(
                                            disabledColor: Colors.grey,
                                            color: Get.theme.colorScheme.primary,
                                            onPressed: nextSong.value
                                                ? () async {
                                              nextSong.value = false;
                                              _assetsAudioPlayer.next().whenComplete(() => nextSong.value = true);
                                            }
                                                : null,
                                            icon: Icon(
                                              color: kWhiteColor,
                                              Icons.skip_next_rounded,
                                              size: 25.sp,
                                            ),
                                          );
                                        }),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (infos != null)
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: kBlackColor,
                            inactiveTrackColor: Colors.yellow,
                            trackHeight: 2.5,
                            thumbColor:  kBlackColor,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0.0,
                            ),
                            overlayColor: Colors.transparent,
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 2.0),
                          ),
                          child: Center(
                            child: Slider(
                              min: 0.0,
                              max: infos.duration.inMilliseconds.toDouble(),
                              value: infos.currentPosition.inMilliseconds.toDouble(),
                              onChanged: (double value) {},
                            ),
                          ),
                        ),
                      if (Platform.isIOS)
                        SizedBox(
                          height: 15.h,
                        ),
                    ],
                  ),
                ),
              );
            });
      }),
    )
        : const SizedBox.shrink();
  });
}