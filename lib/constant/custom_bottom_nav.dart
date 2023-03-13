// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:music_app_flutter_ui/constant/color_constant.dart';
// import 'package:music_app_flutter_ui/constant/common_container.dart';
// import 'package:music_app_flutter_ui/constant/img_constant.dart';
//
// import '../screen/bottom_sheet.dart';
//
// class CustomBottomNavPage extends StatefulWidget {
//   const CustomBottomNavPage({Key? key}) : super(key: key);
//
//   @override
//   State<CustomBottomNavPage> createState() => _CustomBottomNavPageState();
// }
//
// class _CustomBottomNavPageState extends State<CustomBottomNavPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       isButtonShow.value;
//       return Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           padding: EdgeInsets.only(left: 20, right: 20),
//           margin: EdgeInsets.symmetric(horizontal: isButtonShow.value ? 60 : 90),
//           height: 60.h,
//           // width: 200.w,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Color(0Xff4b2df6)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Icon(Icons.copy, color: kWhiteColor, size: 25.h),
//               if (isButtonShow.value)
//                 InkWell(
//                   onTap: () async {
//                     await showModalBottomSheet<void>(
//                       isScrollControlled: true,
//                       backgroundColor: Colors.transparent,
//                       context: context,
//                       builder: (BuildContext context) {
//                         return LiveButtonBottomSheet();
//                       },
//                     );
//                   },
//                   child: CircleAvatar(
//                     maxRadius: 25,
//                     backgroundImage: AssetImage(dron),
//                   ),
//                 ),
//               const CircleAvatar(
//                 backgroundImage: AssetImage(profile),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
