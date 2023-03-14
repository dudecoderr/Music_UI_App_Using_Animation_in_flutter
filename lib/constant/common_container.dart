import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app_flutter_ui/constant/string_constant.dart';
import '../screen/sub_screen.dart';
import 'color_constant.dart';
import 'img_constant.dart';

RxBool isButtonShow = false.obs;

class Designer extends StatelessWidget {
  const Designer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 900.h,
        width: 450,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                DesignerList(
                  function: () {},
                  titles: edx,
                  photo: artists1,
                  desc: bloodyTear,
                  image: dron,
                  url: 'assets/Ishq Mein - Sachet Tandon 128 Kbps.mp3',
                  index: 0,
                ),
                SizedBox(height: 13.h),
                DesignerList(
                  function: () {},
                  titles: justin,
                  photo: artists2,
                  desc: loveMe,
                  image: audio,
                  url: 'assets/Desh Mere - Bhuj The Pride Of India 128 Kbps.mp3',
                  index: 1,
                ),
                SizedBox(height: 15.h),
                DesignerList(
                  function: () {},
                  titles: armaanMalik,
                  photo: artists3,
                  desc: flyAway,
                  image: audio1,
                  url: 'assets/Bewafa Tera Muskurana - Jubin Nautiyal 128 Kbps.mp3',
                  index: 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DesignerList extends StatefulWidget {
  final String titles;
  final String photo;
  final String? desc;
  final String? image;
  final String? url;
  final Function? function;
  final int index;

  const DesignerList({
    Key? key,
    this.function,
    required this.titles,
    required this.photo,
    this.desc,
    this.image,
    this.url,
    required this.index,
  }) : super(key: key);

  @override
  State<DesignerList> createState() => _DesignerListState();
}

class _DesignerListState extends State<DesignerList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (
            context,
          ) {
            return SubCategoryPage(
              image: widget.image,
              desc: widget.desc,
              photo: widget.photo,
              title: widget.titles,
              url: widget.url!,
            );
          }),
        ).whenComplete(() {
          isButtonShow.value = true;
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        height: 280.h,
        width: 350.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          image: DecorationImage(image: AssetImage(widget.image.toString()), fit: BoxFit.fill),
        ),
        child: Column(children: [
          CircleAvatar(
            maxRadius: 25.h,
            backgroundColor: const Color(0XFF2f6afb),
            backgroundImage: AssetImage(widget.photo.toString()),
          ),
          Text(
            widget.titles,
            style: TextStyle(
              color: kWhiteColor,
              fontFamily: "Quicksand",
              fontSize: 15.sp,
            ),
          ),
          Text(
            widget.desc!,
            style: TextStyle(
              color: kWhiteColor,
              fontFamily: "Quicksand",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ]),
      ),
    );
  }
}
