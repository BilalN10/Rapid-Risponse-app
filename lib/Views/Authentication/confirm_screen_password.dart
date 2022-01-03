import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class ConfirmScreen extends StatefulWidget {
  static String tag = 'confirm-page';

  @override
  _ConfirmScreenState createState() => new _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
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
              hintText: "Enter Your Code"),
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
          //OneContext().pushNamedAndRemoveUntil(Routes.signin_screen,  (Route<dynamic> route) => false);
        },
      ),
    );

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
                  OneContext().pop();
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
                  child: new SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Confrim",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.title),
                            )),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "We have sent an e-mail with a code for confirmation.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: MyColors.title),
                            )),
                        SizedBox(height: 16.0),
                        name,
                        SizedBox(height: 5.0),
                        resendLabel,
                        SizedBox(height: 16.0),
                        continueButton,
                      ],
                    ),
                  ),
                ),
              )),
        ));
  }
}
