import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Authentication/sign_screen.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/app_bar_widget.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class FacilityCode extends StatelessWidget {
  const FacilityCode({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authenticateAppbar("Facility Code"),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              //Image
              Image.asset(
                'assets/images/facility_code.png',
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              //Insert code textfield
              Container(
                padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.input_border),
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: MyColors.hint,
                            fontSize: 1.8 * SizeConfig.textMultiplier),
                        hintText: "Insert Code"),
                    onChanged: (value) {}),
              ),
              SizedBox(height: 8 * SizeConfig.heightMultiplier),
              Text(
                "Your administrator has provided a facility code in order to register you to the proper building.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 1.8 * SizeConfig.textMultiplier,
                    color: MyColors.grey_3),
              ),
              SizedBox(height: 2 * SizeConfig.heightMultiplier),
              Text(
                "Please enter the code that you have been provided.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.grey_3,
                  fontSize: 1.8 * SizeConfig.textMultiplier,
                ),
              ),
              SizedBox(height: 15 * SizeConfig.heightMultiplier),

              ProgressButton(
                color: MyColors.primary,
                defaultWidget: Container(
                  child: Text(
                    "Confirm Property",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 2 * SizeConfig.textMultiplier),
                  ),
                ),
                progressWidget: const SmartButtonIndicatorWidget(),
                borderRadius: 12,
                type: ProgressButtonType.Flat,
                height: 56,
                onPressed: () async {
                  Get.to(() => SigninScreen());
                },
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'I Already have accout, Login Now.',
                    style: TextStyle(
                        color: MyColors.grey,
                        fontSize: 1.5 * SizeConfig.textMultiplier,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  //OneContext().pushNamed(Routes.forgot_pass);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
