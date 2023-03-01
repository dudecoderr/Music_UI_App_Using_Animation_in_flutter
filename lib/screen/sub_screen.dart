import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/audio_wave.dart';
import '../constant/color_constant.dart';
import 'audio/playingControls.dart';

class SubCategoryPage extends StatefulWidget {
  final String? image;
  final String? desc;
  final String? title;
  final String? photo;



  SubCategoryPage({Key? key, this.image, this.desc, this.title, this.photo, }) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> with TickerProviderStateMixin {


  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[

    Audio(
      'assets/Bewafa Tera Muskurana - Jubin Nautiyal 128 Kbps.mp3',
    ),
    Audio(
      'assets/Desh Mere - Bhuj The Pride Of India 128 Kbps.mp3',
    ),
    Audio(
      'assets/Ishq Mein - Sachet Tandon 128 Kbps.mp3',

    ),
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
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
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height:MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(widget.image!), fit: BoxFit.cover)),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 55.h,
                ),
                child: Column(children: [
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
                  _assetsAudioPlayer.builderCurrent(
                      builder: (context, Playing? playing) {
                        return Column(
                          children: <Widget>[
                            _assetsAudioPlayer.builderLoopMode(
                              builder: (context, loopMode) {
                                return PlayerBuilder.isPlaying(
                                    player: _assetsAudioPlayer,
                                    builder: (context, isPlaying) {
                                      return PlayingControls(
                                        loopMode: loopMode,
                                        isPlaying: isPlaying,
                                        isPlaylist: true,
                                        onStop: () {
                                          _assetsAudioPlayer.stop();
                                        },
                                        toggleLoop: () {
                                          _assetsAudioPlayer.toggleLoop();
                                        },
                                        onPlay: () {
                                          _assetsAudioPlayer.playOrPause();
                                        },
                                        onNext: () {
                                          //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                          _assetsAudioPlayer.next(
                                              keepLoopMode:
                                              true /*keepLoopMode: false*/);
                                        },
                                        onPrevious: () {
                                          _assetsAudioPlayer.previous(
                                            /*keepLoopMode: false*/);
                                        },
                                      );
                                    });
                              },
                            ),
                            _assetsAudioPlayer.builderRealtimePlayingInfos(
                                builder: (context, RealtimePlayingInfos? infos) {
                                  if (infos == null) {
                                    return SizedBox();
                                  }
                                  return Column(
                                    children: [
                                      Audio_Wave_Page(),
                                      // PositionSeekWidget(
                                      //   currentPosition: infos.currentPosition,
                                      //   duration: infos.duration,
                                      //   seekTo: (to) {
                                      //     _assetsAudioPlayer.seek(to);
                                      //   },
                                      // ),

                                    ],
                                  );
                                }),

                          ],
                        );
                      }),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
