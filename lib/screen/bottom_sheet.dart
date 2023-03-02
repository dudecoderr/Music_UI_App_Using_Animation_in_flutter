import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app_flutter_ui/constant/color_constant.dart';
import 'package:music_app_flutter_ui/constant/img_constant.dart';
import '../constant/string_constant.dart';

class LiveButtonBottomSheet extends StatefulWidget {
  const LiveButtonBottomSheet({Key? key}) : super(key: key);

  @override
  State<LiveButtonBottomSheet> createState() => _LiveButtonBottomSheetState();
}

class _LiveButtonBottomSheetState extends State<LiveButtonBottomSheet> with TickerProviderStateMixin  {
  int timeIndexSelected = 0;
  late AnimationController _animationController;
  bool _isPlaying = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isFinished = true;
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isFinished) {
      // if animation has finished, reset it
      _animationController.reset();
      setState(() {
        _isFinished = false;
      });
    }
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _animationController.forward();
      } else {
        _animationController.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.h,
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), boxShadow: [
              BoxShadow(
                color: kWhiteColor.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 5,
                offset: Offset(0,12), // changes position of shadow
              ),
            ],),
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


          Padding(
            padding:  EdgeInsets.only(right: 20.w, left: 20.w),
            child: Lottie.asset(
              'assets/wave.json',
              controller: _animationController,
              onLoaded: (composition) {
                _animationController
                  ..duration = composition.duration
                  ..forward().whenComplete(() {});
              },
            ),
          ),
          ///double song vage che ee atyre nay jovu
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround ,children: [
            Icon(Icons.shuffle,color: kWhiteColor,size: 25.h,),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,color: kWhiteColor,size: 25.sp),
              onPressed: _togglePlayPause,
            ),
            Icon(Icons.wifi_tethering,color: kWhiteColor,size: 25.h,),
          ],)
        ],
      ),
    );
  }
}
