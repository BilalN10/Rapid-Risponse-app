import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

Widget authenticateAppbar(String title) {
  return AppBar(
    centerTitle: true,
    // leading: BackButton(color: JssColors.judul),
    leading: Container(
      margin: EdgeInsets.only(left: 4 * SizeConfig.widthMultiplier),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: MyColors.bg_button_back,
      ),
      alignment: Alignment.center,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: MyColors.grey_3,
          size: 5 * SizeConfig.imageSizeMultiplier,
        ),
        onPressed: () {
          Get.back();
          // OneContext().pop();
        },
      ),
    ),
    title: Text(
      title,
      style:
          const TextStyle(color: MyColors.primary, fontWeight: FontWeight.bold),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}

Widget rapidResponseAppbar() {
  return AppBar(
    // leading: BackButton(color: JssColors.judul),
    leading: Container(
      margin: const EdgeInsets.only(left: 16.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: IconButton(
        icon: Image.asset('assets/images/home.png'),
        onPressed: () {
          //OneContext().pushNamed(LoginScreen.tag);
        },
      ),
    ),
    title: const Text(
      "Rapid Response",
      style: TextStyle(color: MyColors.secondary, fontWeight: FontWeight.bold),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              //  _drawerKey.currentState?.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: MyColors.grey_3,
              size: 26.0,
            ),
          )),
    ],
  );
}
