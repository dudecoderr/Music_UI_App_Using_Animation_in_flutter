import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/color_constant.dart';
import '../constant/common_container.dart';
import '../constant/custom_bottom_nav.dart';
import '../constant/img_constant.dart';
import '../constant/list.dart';
import '../constant/string_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 446.w,
            height: 306.h,
            decoration: const BoxDecoration(
              color: kindigoColor
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 42),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        swipeDown,
                        style: TextStyle(fontFamily: "Quicksand",color: Colors.white54,fontSize: 20.sp),
                      )),
                ),
              ],
            ),
          ),
          Positioned(
            top: 85.h,
            child: Column(
              children: [
                Container(
                  width: 360.w,
                  height: 460.h,
                  decoration: BoxDecoration(
                    color: kBlueColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60.r), topRight: Radius.circular(60.r),),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 55.h, right: 30.w, left: 30.w),
                        child: CircleAvatar(
                          maxRadius: 30.h,
                          backgroundColor: const Color(0XFF2f6afb),
                          backgroundImage: const AssetImage(profile),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30.w, left: 30.w),
                        child: Text(
                          goodEvening,
                          style: TextStyle(fontFamily: "Quicksand", fontSize: 55.sp, color: kWhiteColor, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30.w, left: 30.w),
                        child: SizedBox(
                          height: 45.h,
                          width: 130.w,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const StoragePage(),
                              //   ),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              discover,
                              style: TextStyle(fontWeight: FontWeight.w600, fontFamily: "Quicksand", fontSize: 15.sp, color: kBlueColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 510),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 1306.h,
                    width: 500.w,
                    padding: EdgeInsets.only(right: 30.w, left: 30.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60.r), topRight: Radius.circular(50.r)),
                      color: kWhiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          favouriteArtists,
                          style: TextStyle(fontFamily: "Quicksand", fontSize: 25.sp, color: Color(0XFF23115a), fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const ArtistHorizontalListview(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          recentlyPlayed,
                          style: TextStyle(fontFamily: "Quicksand", fontSize: 25.sp, color: Color(0XFF23115a), fontWeight: FontWeight.w900),
                        ),
                        Designer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30.w,
            left: 30.w,
            child: CustomBottomNavPage(),
          ),
        ],
      ),
    );
  }
}
