import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class MyDialog {
  static void sigleButtonDailog(
      {String title, String middleText, VoidCallback function, buttonText}) {
    Get.defaultDialog(actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 4 * SizeConfig.heightMultiplier,
            width: 20 * SizeConfig.widthMultiplier,
            child: ProgressButton(
              color: MyColors.primary,
              defaultWidget: Container(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      // fontWeight: FontWeight.bold
                      color: Colors.white),
                ),
              ),
              progressWidget: SmartButtonIndicatorWidget(),
              borderRadius: 12,
              type: ProgressButtonType.Flat,
              height: 56,
              onPressed: function,
            ),
          ),
        ],
      )
    ], title: title, middleText: middleText);
  }

  static void doubleButtonDailog(
      {String title,
      String middleText,
      VoidCallback onCofirmfunction,
      confirmbuttonText,
      VoidCallback onCancelfunction,
      cancelbuttonText}) {
    Get.defaultDialog(actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 4 * SizeConfig.heightMultiplier,
            width: 20 * SizeConfig.widthMultiplier,
            child: ProgressButton(
              color: MyColors.grey,
              defaultWidget: Container(
                child: Text(
                  cancelbuttonText,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      // fontWeight: FontWeight.bold
                      color: Colors.white),
                ),
              ),
              progressWidget: SmartButtonIndicatorWidget(),
              borderRadius: 12,
              type: ProgressButtonType.Flat,
              height: 56,
              onPressed: onCancelfunction,
            ),
          ),
          SizedBox(
            height: 4 * SizeConfig.heightMultiplier,
            width: 20 * SizeConfig.widthMultiplier,
            child: ProgressButton(
              color: MyColors.primary,
              defaultWidget: Container(
                child: Text(
                  confirmbuttonText,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      // fontWeight: FontWeight.bold
                      color: Colors.white),
                ),
              ),
              progressWidget: const SmartButtonIndicatorWidget(),
              borderRadius: 12,
              type: ProgressButtonType.Flat,
              height: 56,
              onPressed: onCofirmfunction,
            ),
          ),
        ],
      )
    ], title: title, middleText: middleText);
  }
}
