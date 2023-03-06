import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app_flutter_ui/constant/color_constant.dart';
import 'package:music_app_flutter_ui/constant/img_constant.dart';
import '../constant/string_constant.dart';
import 'audio/parent_seek.dart';
import 'audio/playingControls.dart';

class LiveButtonBottomSheet extends StatefulWidget {
  const LiveButtonBottomSheet({Key? key}) : super(key: key);

  @override
  State<LiveButtonBottomSheet> createState() => _LiveButtonBottomSheetState();
}

class _LiveButtonBottomSheetState extends State<LiveButtonBottomSheet> with TickerProviderStateMixin {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    Audio(
      'assets/Bewafa Tera Muskurana - Jubin Nautiyal 128 Kbps.mp3',
      metas: Metas(
        title: "Bewafa Tera Muskurana",
        artist: "Jubin Nautiyal",
        album: "CountryAlbum",
        image: MetasImage.asset("assets/artist3.jpg"), //can be MetasImage.network
      ),
    ),
    Audio(
      'assets/Desh Mere - Bhuj The Pride Of India 128 Kbps.mp3',
      metas: Metas(
        title: "Desh Mere",
        artist: "Arjit Sinh",
        album: "CountryAlbum",
        image: MetasImage.asset("assets/artist4.jpeg"), //can be MetasImage.network
      ),
    ),
  ];

  late AnimationController _animationController;

  ///
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _assetsAudioPlayer.dispose();
    print('dispose');
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ====================
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                height: 4.h,
                width: 70.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp), color: Colors.white54),
              ),
            ),
          ),
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
                  offset: Offset(0, 12), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(borderRadius: BorderRadius.circular(20.r), child: Image.asset(dron, fit: BoxFit.cover)),
          ),

          SizedBox(height: 15.h),
          Text(
            edx,
            style: TextStyle(color: Colors.white54, fontFamily: 'Quicksand', fontWeight: FontWeight.w500, fontSize: 20.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            bloodyTear,
            style: TextStyle(color: kWhiteColor, fontFamily: 'Quicksand', fontWeight: FontWeight.w700, fontSize: 25.sp),
          ),
          _assetsAudioPlayer.builderCurrent(builder: (context, Playing? playing) {
            return Column(
              children: <Widget>[
                _assetsAudioPlayer.builderLoopMode(
                  builder: (context, loopMode) {
                    return PlayerBuilder.isPlaying(
                        player: _assetsAudioPlayer,
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
                                        _animationController..repeat().whenComplete(() {});
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
                                        Color(0xFFffffff).withOpacity(0.0),
                                        Color(0xFFFFFFFF).withOpacity(0.0),
                                      ], stops: [
                                        0.1,
                                        1,
                                      ]),
                                      borderGradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFffffff).withOpacity(0.0),
                                          Color((0xFFFFFFFF)).withOpacity(0.0),
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
                                  _assetsAudioPlayer.stop();

                                  _animationController.stop();
                                },
                                toggleLoop: () {
                                  _assetsAudioPlayer.toggleLoop();
                                  _animationController.reset();
                                },
                                onPlay: () {
                                  _assetsAudioPlayer.playOrPause();
                                  if (_assetsAudioPlayer.isPlaying.value == true) {
                                    _animationController.stop();
                                  } else {
                                    _animationController.repeat();
                                  }
                                },
                                onNext: () {
                                  //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                  _assetsAudioPlayer.next(keepLoopMode: true /*keepLoopMode: false*/);
                                  _animationController.reset();
                                },
                                onPrevious: () {
                                  _assetsAudioPlayer.previous(/*keepLoopMode: false*/);
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              _assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
                                if (infos == null) {
                                  return SizedBox();
                                }
                                //print('infos: $infos');
                                return Padding(
                                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.shuffle, color: kWhiteColor, size: 35.sp),
                                      PositionSeekWidget(
                                        currentPosition: infos.currentPosition,
                                        duration: infos.duration,
                                        seekTo: (to) {
                                          _assetsAudioPlayer.seek(to);
                                        },
                                      ),
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
      ),
    );
  }
}
