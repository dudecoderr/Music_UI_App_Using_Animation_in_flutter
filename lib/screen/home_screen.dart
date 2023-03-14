import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:music_app_flutter_ui/screen/sub_screen.dart';
import '../constant/audio_constant.dart';
import '../constant/color_constant.dart';
import '../constant/common_container.dart';
import '../constant/img_constant.dart';
import '../constant/list.dart';
import '../constant/string_constant.dart';
import 'bottom_sheet.dart';


class HomePage extends StatefulWidget {
  final String? url;
  final String? image;
  final String? desc;
  final String? title;

  const HomePage({
    Key? key,
    this.url,
    this.image,
    this.desc,
    this.title,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController(initialScrollOffset: 0.0);
  @override
  void initState() {
    controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange) {}
    if (controller.offset <= controller.position.minScrollExtent && !controller.position.outOfRange) {
      print('reach the end left');
      isButtonShow.value = false;
      print('reach the end right');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 446.w,
            height: 306.h,
            decoration: const BoxDecoration(color: kindigoColor),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 42),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        swipeDown,
                        style: TextStyle(fontFamily: "Quicksand", color: Colors.white54, fontSize: 20.sp),
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.r),
                      topRight: Radius.circular(60.r),
                    ),
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
                            onPressed: () {},
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
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.only(top: 510),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 1306.h,
                    width: 500.w,
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
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Text(
                            favouriteArtists,
                            style: TextStyle(fontFamily: "Quicksand", fontSize: 25.sp, color: Color(0XFF23115a), fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const ArtistHorizontalListview(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Text(
                            recentlyPlayed,
                            style: TextStyle(fontFamily: "Quicksand", fontSize: 25.sp, color: Color(0XFF23115a), fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Designer(),
                        ),
                        slidablePanelHeader(
                          context: context,
                          onTap: () async {
                            Get.to(SubCategoryPage(id: assetsAudioPlayer.current.value!.audio.audio.metas.id),
                                transition: Transition.native, duration: const Duration(seconds: 1));
                          },
                        ),
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
            child: Obx(() {
              isButtonShow.value;
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.symmetric(horizontal: isButtonShow.value ? 60 : 90),
                  height: 60.h,
                  // width: 200.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Color(0Xff4b2df6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.copy, color: kWhiteColor, size: 25.h),
                      if (isButtonShow.value)
                        assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
                          return PlayerBuilder.current(
                              player: assetsAudioPlayer,
                              builder: (context, abc) {


                                return InkWell(
                                  onTap: () async {
                                     showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (
                                    BuildContext context,
                                    ) {

                                    return LiveButtonBottomSheet(
                                    desc: abc.audio.audio.metas.album,
                                    title: abc.audio.audio.metas.title,
                                    image:abc.audio.audio.metas.image!.path ,
                                    );
                                    },
                                    );
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 25,
                                    backgroundImage: AssetImage(abc.audio.audio.metas.image!.path),
                                  ),
                                );
                              });
                        }),
                      const CircleAvatar(
                        backgroundImage: AssetImage(profile),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
