import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../constant/color_constant.dart';

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
                  SizedBox(height:250.h),
                  Lottie.asset(
                    'assets/wave.json',
                    controller: _animationController,
                    onLoaded: (composition) {
                      _animationController
                        ..duration = composition.duration
                        ..forward().whenComplete(() {});
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30.w,left: 30.w,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.shuffle,
                          color: kWhiteColor,
                          size: 25.h,
                        ),
                        IconButton(
                          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,color: kWhiteColor,size: 25.sp),
                          onPressed: _togglePlayPause,
                        ),
                        Icon(
                          Icons.wifi_tethering,
                          color: kWhiteColor,
                          size: 25.h,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
