// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rapid_response/SizeConfig/size_config.dart';
// import 'package:rapid_response/Views/Chat/doccotor_message.dart';
// import 'package:rapid_response/Views/Constants/colors.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//       //  backgroundColor: kLightyellow,
//         title: Text("Chat"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 90 * SizeConfig.heightMultiplier,
//             child: ListView.builder(
//                 itemCount: usersList.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Get.to(DoctorMessage(
//                         userModel: usersList[index],
//                       ));
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(5),
//                       height: 9 * SizeConfig.heightMultiplier,
//                       // color: Colors.amber,
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 10 * SizeConfig.heightMultiplier,
//                             width: 15 * SizeConfig.widthMultiplier,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.blue,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         "assets/images/account.png"))),
//                           ),
//                           SizedBox(
//                             width: 2 * SizeConfig.widthMultiplier,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("namre"),
//                               Text(
//                                 "You : Where are you",
//                                 style: TextStyle(
//                                     fontSize: 1 * SizeConfig.textMultiplier),
//                               )
//                             ],
//                           ),
//                           Spacer(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 index == 3 || index == 1 ? "offline" : "online",
//                                 style: TextStyle(
//                                     color: index == 3 || index == 1
//                                         ? Colors.red
//                                         : MyColors.primary),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             width: 4 * SizeConfig.widthMultiplier,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
