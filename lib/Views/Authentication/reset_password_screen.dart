import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/mytextfield.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String tag = 'confirm-page';

  @override
  _ConfirmScreenState createState() => new _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());
  TextEditingController resetPasswordEmail = TextEditingController();
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = Container(
      padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.input_border),
          borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: MyColors.hint),
              hintText: "Password"),
          onChanged: (value) {}),
    );

    final continueButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ProgressButton(
        color: MyColors.primary,
        defaultWidget: Container(
          child: Text(
            "Continue",
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        progressWidget: SmartButtonIndicatorWidget(),
        borderRadius: 12,
        type: ProgressButtonType.Flat,
        height: 56,
        onPressed: () async {
          _inputValidation();
          // FocusScope.of(context).unfocus();
          // if (_loginStore.userEmail.isNotEmpty &&
          //     _loginStore.password.isNotEmpty) {
          //   int score = await Future.delayed(
          //       const Duration(milliseconds: 1000), () => 42);
          //   return () {
          //     _loginStore.login();
          //   };
          // } else {
          //   FocusScope.of(context).unfocus();
          //   warning("Username dan password tidak boleh kosong");
          // }
          //  OneContext().pushNamedAndRemoveUntil(Routes.signin_screen,  (Route<dynamic> route) => false);
        },
      ),
    );
    Widget resetEmailField(String text) {
      return Container(
        padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.input_border),
            borderRadius: BorderRadius.circular(10.0)),
        child: TextField(
            controller: resetPasswordEmail,
            //obscureText: !_loginStore.passwordVisibility,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  onPressed: () {
                    // _authStore.passwordVisibility =
                    //     !_authStore.passwordVisibility;
                  },
                ),
                // icon: Icon(
                //   Icons.lock,
                //   color: Colors.grey.withOpacity(0.2),
                // ),
                border: InputBorder.none,
                hintStyle: TextStyle(color: MyColors.hint),
                hintText: text),
            onChanged: (value) {
              //_loginStore.setPassword(value);
            }),
      );
    }

    final resendLabel = TextButton(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Resend Code',
          style: TextStyle(
              color: MyColors.grey,
              fontSize: 12,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold),
        ),
      ),
      onPressed: () {
        //OneContext().pushNamed(Routes.forgot_pass);
      },
    );
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            // leading: BackButton(color: JssColors.judul),
            leading: Container(
              margin: EdgeInsets.only(left: 16.0),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.bg_button_back,
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: MyColors.grey_3,
                  size: 20.0,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          body: GestureDetector(
              onTap: () {
                // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
                if (Platform.isIOS) hideKeyboard(context);
              },
              child: Container(
                // alignment: Alignment.centerLeft,
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5 * SizeConfig.heightMultiplier,
                        ),
                        const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.title),
                            )),
                        const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Enter your Email",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: MyColors.title),
                            )),
                        //const SizedBox(height: 16.0),
                        SizedBox(
                          height: 8 * SizeConfig.heightMultiplier,
                        ),
                        Form(
                          key: _formKey,
                          child: MyTextField(
                            isPass: false,
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return "Required";
                              } else if (!GetUtils.isEmail(value)) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            controller: userAthenticationController
                                .resetEmailController,
                            hintText: "E-mail",
                            icon: Icons.person,
                            isNumberField: false,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        //passwardField("Confirm password"),
                        const SizedBox(height: 5.0),
                        //resendLabel,
                        SizedBox(height: 30 * SizeConfig.heightMultiplier),
                        continueButton,
                      ],
                    ),
                  ),
                ),
              )),
        ));
  }

  void _inputValidation() {
    if (_formKey.currentState.validate()) {
      userAthenticationController
          .resetPassword(userAthenticationController.resetEmailController.text);
    } else {
      print("Form is not validate");
    }
  }
}
