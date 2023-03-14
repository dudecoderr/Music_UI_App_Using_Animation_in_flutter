import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app_flutter_ui/screen/bottom_sheet.dart';
import '../constant/color_constant.dart';
import 'audio/parent_seek.dart';
import 'audio/playingControls.dart';

class SubCategoryPage extends StatefulWidget {
  final String? image;
  final String? desc;
  final String? title;
  final String? photo;
  final String? url;
  final String? id;

  const SubCategoryPage({
    Key? key,
    this.image,
    this.desc,
    this.title,
    this.photo,
    this.url,
    this.id,
  }) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> with TickerProviderStateMixin {
  final List<StreamSubscription> _subscriptions = [];

  late AnimationController _animationController;
  bool showLiveButton = true;

  @override
  void initState() {
    super.initState();
    if (assetsAudioPlayer.isPlaying.value) {

      assetsAudioPlayer.dispose();
    }
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
  }

  void openPlayer() async {
    assetsAudioPlayer.open(
      Audio(widget.url!,metas: Metas(
          image: MetasImage.asset(widget.image!),title: widget.title,album: widget.desc,
      )),
      autoStart: false,
      showNotification: true,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
      return PlayerBuilder.current(
          player: assetsAudioPlayer,
          builder: (context, value) {
            return  Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(widget.image!), fit: BoxFit.cover)),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 55.h,
                      ),
                      child: Column(children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context,
                                    widget.image,
                                   );
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white54,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: kindigoColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          maxRadius: 35.h,
                          backgroundColor: const Color(0XFF2f6afb),
                          backgroundImage: AssetImage(widget.photo!),
                        ),
                        Text(
                          widget.title!,
                          style: TextStyle(
                            color: kWhiteColor,
                            fontFamily: "Quicksand",
                            fontSize: 24.sp,
                          ),
                        ),
                        Text(
                          widget.desc!,
                          style: TextStyle(
                            color: kWhiteColor,
                            fontFamily: "Quicksand",
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 240.h,
                        ),
                        assetsAudioPlayer.builderCurrent(builder: (context, Playing? playing) {
                          return Column(
                            children: <Widget>[
                              assetsAudioPlayer.builderLoopMode(
                                builder: (context, loopMode) {
                                  return PlayerBuilder.isPlaying(
                                      player: assetsAudioPlayer,
                                      builder: (context, isPlaying,) {
                                        return Column(
                                          children: [
                                            showLiveButton
                                                ? const SizedBox()
                                                : Stack(
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
                                                      const    Color(0xFFffffff).withOpacity(0.0),
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
                                                assetsAudioPlayer.pause();
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
                                                setState(() {
                                                  showLiveButton = false;
                                                });
                                              },
                                              onNext: () {
                                                //assetsAudioPlayer.forward(Duration(seconds: 10));
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
                                              return showLiveButton
                                                  ? const SizedBox()
                                                  : Padding(
                                                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Icon(Icons.shuffle, color: kWhiteColor, size: 35.sp),
                                                    PositionSeekWidget(
                                                      currentPosition: infos.currentPosition,
                                                      duration: infos.duration,
                                                      seekTo: (to) {
                                                        assetsAudioPlayer.seek(to);
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
                              ),
                            ],
                          );
                        }),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          });
    }),
    );
  }
}
