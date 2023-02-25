import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app_flutter_ui/constant/color_constant.dart';
import 'package:music_app_flutter_ui/constant/string_constant.dart';

import 'img_constant.dart';


/// ============================= Cast Horizontal Listview =============================
class ArtistHorizontalListview extends StatelessWidget {
  const ArtistHorizontalListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:  const [
              ArtistCategory(image_location:artists1,title:edx ),
              ArtistCategory(image_location:artists2,title: justin),
              ArtistCategory(image_location:artists3,title:armaanMalik ),
              ArtistCategory(image_location:artists4,title: darshan),
              ArtistCategory(image_location:artists5,title:atifAslam ),
            ],
          ),
        ),
      ],
    );
  }
}

class ArtistCategory extends StatelessWidget {
  final String image_location;
  final String title;

  const ArtistCategory({super.key, required this.image_location, required this.title, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      height: 220.h,
      child: ListTile(
        /// =================== Image ===================
        title: Container(
          height: 120.h,width: 100.w,
          decoration: BoxDecoration(),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),child: Image.asset(image_location,fit: BoxFit.cover)),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(fontWeight: FontWeight.w700,color: kBlueColor,fontFamily: "Quicksand",fontSize: 14.sp)),
            ],
          ),
        ),
      ),
    );
  }
}