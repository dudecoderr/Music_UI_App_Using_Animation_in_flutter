import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app_flutter_ui/constant/color_constant.dart';
import 'audio/playingControls.dart';

AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

class LiveButtonBottomSheet extends StatefulWidget {
  final String? url;
  final String? image;
  final String? desc;
  final String? title;

  const LiveButtonBottomSheet({Key? key, this.url, this.image, this.desc, this.title}) : super(key: key);

  @override
  State<LiveButtonBottomSheet> createState() => _LiveButtonBottomSheetState();
}

class _LiveButtonBottomSheetState extends State<LiveButtonBottomSheet> with TickerProviderStateMixin {
  final List<StreamSubscription> _subscriptions = [];

  late AnimationController _animationController;
  bool showLiveButton = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
    _subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
    }));
    _subscriptions.add(assetsAudioPlayer.audioSessionId.listen((sessionId) {
    }));
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480.h,
      decoration: BoxDecoration(
        color: kBlueColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.r),
          topRight: Radius.circular(60.r),
        ),
      ),
      child: assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
        return PlayerBuilder.current(
            player: assetsAudioPlayer,
            builder: (context, value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  Container(
                    height: 120.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: kWhiteColor.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: const Offset(0, 12), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r), child: Image.asset(value.audio.audio.metas.image!.path, fit: BoxFit.cover)),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    value.audio.audio.metas.title!,
                    style: TextStyle(color: Colors.white54, fontFamily: 'Quicksand', fontWeight: FontWeight.w500, fontSize: 20.sp),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                   value.audio.audio.metas.album!,
                    style: TextStyle(color: kWhiteColor, fontFamily: 'Quicksand', fontWeight: FontWeight.w700, fontSize: 25.sp),
                  ),
                  SizedBox(height: 10.h),
                  assetsAudioPlayer.builderCurrent(builder: (context, Playing? playing) {
                    return Column(
                      children: <Widget>[
                        assetsAudioPlayer.builderLoopMode(
                          builder: (context, loopMode) {
                            return PlayerBuilder.isPlaying(
                                player: assetsAudioPlayer,
                                builder: (context, isPlaying) {
                                  return Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 20.w, left: 20.w),
                                            child: Lottie.asset(
                                              'assets/wave.json',
                                              repeat: true,
                                              controller: _animationController,
                                              onLoaded: (composition) {
                                                _animationController.repeat().whenComplete(() {});
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            child: GlassmorphicContainer(
                                              width: 350.w,
                                              height: 100.h,
                                              borderRadius: 20,
                                              blur: 5,
                                              alignment: Alignment.bottomCenter,
                                              border: 2,
                                              linearGradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                                const  Color(0xFFffffff).withOpacity(0.0),
                                                const Color(0xFFFFFFFF).withOpacity(0.0),
                                              ], stops: const [
                                                0.1,
                                                1,
                                              ]),
                                              borderGradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  const Color(0xFFffffff).withOpacity(0.0),
                                                  const Color((0xFFFFFFFF)).withOpacity(0.0),
                                                ],
                                              ),
                                              child: null,
                                            ),
                                          )
                                        ],
                                      ),
                                      PlayingControls(
                                        loopMode: loopMode,
                                        isPlaying: isPlaying,
                                        isPlaylist: true,
                                        onStop: () {
                                          assetsAudioPlayer.stop();

                                          _animationController.stop();
                                        },
                                        toggleLoop: () {
                                          assetsAudioPlayer.toggleLoop();
                                          _animationController.reset();
                                        },
                                        onPlay: () {
                                          assetsAudioPlayer.playOrPause();
                                          if (assetsAudioPlayer.isPlaying.value == true) {
                                            _animationController.stop();
                                          } else {
                                            _animationController.repeat();
                                          }
                                        },
                                        onNext: () {
                                          assetsAudioPlayer.next(keepLoopMode: true /*keepLoopMode: false*/);
                                          _animationController.reset();
                                        },
                                        onPrevious: () {
                                          assetsAudioPlayer.previous(/*keepLoopMode: false*/);
                                        },
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
                                        if (infos == null) {
                                          return const SizedBox();
                                        }
                                        return Padding(
                                          padding: EdgeInsets.only(right: 20.w, left: 20.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.shuffle, color: kWhiteColor, size: 35.sp),
                                              Icon(Icons.wifi_tethering, color: kWhiteColor, size: 35.sp),
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  );
                                });
                          },
                        )
                      ],
                    );
                  }),
                ],
              );
            });
      }),
    );
  }
}
