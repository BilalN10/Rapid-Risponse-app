import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Authentication/reset_password_screen.dart';
import 'package:rapid_response/Views/Authentication/sign_up_screen.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Constants/mydialog.dart';
import 'package:rapid_response/Views/Rapid_Response/rapid_response.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/mytextfield.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());
  @override
  void initState() {
    // userAthenticationController.sendAlertDialog(111);
    userAthenticationController.auth.signOut();
    userAthenticationController.googleSignIn.signOut();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  //@override
  // void initState() {
  //   if (userAthenticationController.users != null) {
  //     userAthenticationController.checkUserAccountSatus();
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Widget passwardField(TextEditingController controller) {
      return Container(
        padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.input_border),
            borderRadius: BorderRadius.circular(10.0)),
        child: TextFormField(
            controller: controller,

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
                icon: Icon(
                  Icons.lock,
                  color: Colors.grey.withOpacity(0.2),
                ),
                border: InputBorder.none,
                hintStyle: const TextStyle(color: MyColors.hint),
                hintText: "Password"),
            onChanged: (value) {
              //_loginStore.setPassword(value);
            }),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 4 * SizeConfig.widthMultiplier),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5 * SizeConfig.heightMultiplier,
                    ),
                    //app Logo
                    Image.asset(
                      'assets/images/logo.png',
                      height: 64.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 3 * SizeConfig.heightMultiplier,
                    ),
                    //Login Text
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 5 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold,
                          color: MyColors.title),
                    ),
                    SizedBox(
                      height: 4 * SizeConfig.heightMultiplier,
                    ),
                    //Email TextField

                    MyTextField(
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
                      controller:
                          userAthenticationController.signinEmailController,
                      hintText: "E-mail",
                      icon: Icons.person,
                      isNumberField: false,
                    ),

                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                    //Password TextField

                    MypassWordField(
                      isPass: true,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "Required";
                        } else if (value.length < 8) {
                          return "Password too short";
                        } else {
                          return null;
                        }
                      },
                      controller:
                          userAthenticationController.signinPasswordController,
                      hintText: "Password",
                      icon: Icons.person,
                      isNumberField: false,
                    ),

                    // passwardField(
                    //     userAthenticationController.signinPasswordController),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),

                    //Forgot Password Button

                    TextButton(
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: MyColors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => ResetPasswordScreen());
                        // OneContext().pushNamed(Routes.reset_password_screen);
                      },
                    ),
                    SizedBox(
                      height: 3 * SizeConfig.heightMultiplier,
                    ),

                    // Login Button
                    Obx(
                      () => userAthenticationController.isSignInLoading.value
                          ? const CircularProgressIndicator()
                          : ProgressButton(
                              color: MyColors.primary,
                              defaultWidget: Container(
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 2 * SizeConfig.textMultiplier,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              progressWidget:
                                  const SmartButtonIndicatorWidget(),
                              borderRadius: 12,
                              type: ProgressButtonType.Flat,
                              height: 56,
                              onPressed: () async {
                                userAthenticationController
                                    .isSignInLoading.value = true;
                                _inputValidation();
                                //Get.to(() => const RapidResponseScreen());
                                //OneContext().pushNamed(Routes.rapid_response_screen);
                              },
                            ),
                    ),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                    //Login with Google Button
                    ProgressButton(
                      color: MyColors.white,
                      defaultWidget: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/google.png'),
                            Text(
                              "Login With Google",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 1.8 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_3),
                            )
                          ],
                        ),
                      ),
                      progressWidget: const SmartButtonIndicatorWidget(),
                      borderRadius: 12,
                      type: ProgressButtonType.Flat,
                      height: 56,
                      onPressed: () async {
                        userAthenticationController.assignNumber == 111
                            ? userAthenticationController.googleLogin()
                            : bottomSheet();

                        // ;
                      },
                    ),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),

                    //Login with apple  Button
                    ProgressButton(
                      color: MyColors.white,
                      defaultWidget: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/apple.png'),
                            Text(
                              "Login With Apple",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 1.8 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey_3),
                            )
                          ],
                        ),
                      ),
                      progressWidget: const SmartButtonIndicatorWidget(),
                      borderRadius: 12,
                      type: ProgressButtonType.Flat,
                      height: 56,
                      onPressed: () async {
                        // userAthenticationController.googleSignout()
                        //  Get.to(() => RapidResponseScreen());
                      },
                    ),
                    SizedBox(
                      height: 4 * SizeConfig.heightMultiplier,
                    ),

                    Row(children: <Widget>[
                      Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: const Divider(
                              color: Colors.grey,
                              height: 36,
                            )),
                      ),
                      Text("or",
                          style: TextStyle(
                              color: MyColors.grey,
                              fontSize: 2 * SizeConfig.textMultiplier)),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                              left: 5 * SizeConfig.widthMultiplier,
                              right: 5 * SizeConfig.widthMultiplier,
                            ),
                            child: const Divider(
                              color: Colors.grey,
                              height: 36,
                            )),
                      ),
                    ]),
                    SizedBox(
                      height: 3 * SizeConfig.heightMultiplier,
                    ),
                    //signUp text button
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Sign Up Now',
                          style: TextStyle(
                            fontSize: 1.5 * SizeConfig.textMultiplier,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bottomSheet() {
    userAthenticationController.signinPropertyCodeController.clear();

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
              child: Container(
                height: 50 * SizeConfig.heightMultiplier,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 12.0),
                    //   child: Text(
                    //     'Enter your address',
                    //     //style: TextStyles.textBody2
                    //   ),
                    // ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextField(
                        controller: userAthenticationController
                            .signinPropertyCodeController,
                        decoration: const InputDecoration(
                            //                               border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(10),
                            // borderSide:
                            //     const BorderSide(width: 2, color: MyColors.input_border)),

                            hintText: 'Enter Property Code'),
                        // autofocus: true,

                        // controller: _newMediaLinkAddressController,
                      ),
                    ),
                    SizedBox(height: 30),
                    ProgressButton(
                      color: MyColors.primary,
                      defaultWidget: Container(
                        child: Text(
                          "OK",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 2 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      progressWidget: const SmartButtonIndicatorWidget(),
                      borderRadius: 12,
                      type: ProgressButtonType.Flat,
                      height: 56,
                      onPressed: () async {
                        userAthenticationController.googleLogin();
                        // userAthenticationController
                        //     .isSignInLoading.value = true;
                        // _inputValidation();
                        //Get.to(() => const RapidResponseScreen());
                        //OneContext().pushNamed(Routes.rapid_response_screen);
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  void _inputValidation() {
    if (_formKey.currentState.validate()) {
      userAthenticationController.login(
          userAthenticationController.signinEmailController.text,
          userAthenticationController.signinPasswordController.text);
    } else {
      userAthenticationController.isSignInLoading.value = false;
    }
  }
}
