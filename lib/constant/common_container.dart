import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app_flutter_ui/constant/string_constant.dart';

import '../screen/sub_screen.dart';
import 'color_constant.dart';
import 'img_constant.dart';

class Designer extends StatelessWidget {
  const Designer({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height:900.h,
        width: 450,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
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
                ),
                SizedBox(height:13.h),
                DesignerList(
                  function: () {},
                  titles: justin,
                  photo: artists2,
                  desc: loveMe,
                  image: audio,
                ),
                SizedBox(height: 15.h),
                 DesignerList(
                  function: () {},
                  titles: armaanMalik,
                  photo: artists3,
                  desc: flyAway,
                  image: audio1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DesignerList extends StatelessWidget {
  final String titles;
  final String photo;
  final String? desc;
  final String? image;
  final Function? function;
  const DesignerList({Key? key, this.function, required this.titles, required this.photo, this.desc, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context,) =>  SubCategoryPage(image:image,desc: desc,photo: photo,title: titles, ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        height: 280.h,
        width: 350.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          image: DecorationImage(image: AssetImage(image.toString()), fit: BoxFit.fill),
        ),
        child: Column(children: [
          CircleAvatar(
            maxRadius: 25.h,
            backgroundColor: const Color(0XFF2f6afb),
            backgroundImage: AssetImage(photo.toString()),
          ),
          Text(
            titles,
            style: TextStyle(
              color: kWhiteColor,
              fontFamily: "Quicksand",
              fontSize: 15.sp,
            ),
          ),
          Text(
            desc!,
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
