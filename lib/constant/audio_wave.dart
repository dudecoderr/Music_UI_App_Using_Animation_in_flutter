import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Audio_Wave_Page extends StatefulWidget {
  const Audio_Wave_Page({Key? key}) : super(key: key);

  @override
  State<Audio_Wave_Page> createState() => _Audio_Wave_PageState();
}

class _Audio_Wave_PageState extends State<Audio_Wave_Page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AudioWave(
        height: 60.h,
        width: 300.w,
        spacing: 6,
        bars: [
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.20, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.10, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.30, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.70, color: Colors.white),
          AudioWaveBar(
              heightFactor: 0.40, color: Colors.white),


        ],  
      ),
    );
  }
}
