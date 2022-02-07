import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/app_bar_widget.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/mytextfield.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());

  @override
  void initState() {
    //userAthenticationController.sendAlertDialog(111);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: authenticateAppbar("Sign Up"),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10 * SizeConfig.heightMultiplier,
                  ),

                  //User name textField
                  MyTextField(
                    isPass: false,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Required";
                      }
                      //  else if (!GetUtils.isEmail(value)) {
                      //   return "Invalid Email";
                      // }
                      else {
                        return null;
                      }
                    },
                    controller:
                        userAthenticationController.signupUserNameController,
                    hintText: "Name",
                    icon: Icons.person,
                    isNumberField: false,
                  ),
                  // MyTextField(
                  //   isNumberField: false,
                  //   hintText: "Name",
                  //   icon: Icons.person,
                  //   controller:
                  //       userAthenticationController.signupUserNameController,
                  // ),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                  //User Email textField
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
                        userAthenticationController.signupEmailController,
                    hintText: "E-mail",
                    icon: Icons.person,
                    isNumberField: false,
                  ),

                  // MyTextField(
                  //     isNumberField: false,
                  //     hintText: "E-mail",
                  //     icon: Icons.mail,
                  //     controller:
                  //         userAthenticationController.signupEmailController),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                  //Unit Code textField
                  MyTextField(
                    isPass: false,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Required";
                      }
                      //  else if (!GetUtils.isEmail(value)) {
                      //   return "Invalid Email";
                      // }
                      else {
                        return null;
                      }
                    },
                    controller:
                        userAthenticationController.signupUnitCodeController,
                    hintText: "Unit Code",
                    icon: Icons.qr_code,
                    isNumberField: false,
                  ),

                  // MyTextField(
                  //   isNumberField: false,
                  //   hintText: "Unit Code",
                  //   icon: Icons.qr_code,
                  //   controller:
                  //       userAthenticationController.signupUnitCodeController,
                  // ),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                  //Phone Number textField
                  MyTextField(
                    isPass: false,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Required";
                      }
                      //  else if (!GetUtils.isEmail(value)) {
                      //   return "Invalid Email";
                      // }
                      else {
                        return null;
                      }
                    },
                    controller:
                        userAthenticationController.signupPhoneNumberController,
                    hintText: "Phone Number",
                    icon: Icons.phone_iphone_sharp,
                    isNumberField: true,
                  ),

                  // MyTextField(
                  //   isNumberField: true,
                  //   hintText: "Phone Number",
                  //   icon: Icons.phone_iphone_sharp,
                  //   controller:
                  //       userAthenticationController.signupPhoneNumberController,
                  // ),

                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                  //Password textField
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
                        userAthenticationController.signupPasswordController,
                    hintText: "Password",
                    icon: Icons.lock,
                    isNumberField: false,
                  ),

                  // MyTextField(
                  //   isNumberField: false,
                  //   hintText: "Password",
                  //   icon: Icons.lock,
                  //   controller:
                  //       userAthenticationController.signupPasswordController,
                  // ),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                  //User name textField
                  MypassWordField(
                    isPass: true,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Required";
                      } else if (value.length < 8) {
                        return "Password too short";
                      } else if (userAthenticationController
                              .signupPasswordController.text !=
                          userAthenticationController
                              .signupConfirmPasswordController.text) {
                        return "Password did not macth";
                      } else {
                        return null;
                      }
                    },
                    controller: userAthenticationController
                        .signupConfirmPasswordController,
                    hintText: "Password Confirmation",
                    icon: Icons.lock,
                    isNumberField: false,
                  ),

                  // MyTextField(
                  //   isNumberField: false,
                  //   hintText: "Password Confirmation",
                  //   icon: Icons.lock,
                  //   controller: userAthenticationController
                  //       .signupConfirmPasswordController,
                  // ),
                  SizedBox(
                    height: 15 * SizeConfig.heightMultiplier,
                  ),
                  Obx(
                    () => userAthenticationController.isSignUpLoading.value
                        ? const CircularProgressIndicator()
                        : ProgressButton(
                            color: MyColors.primary,
                            defaultWidget: Container(
                              child: Text(
                                "Sign up",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 1.6 * SizeConfig.textMultiplier,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            progressWidget: const SmartButtonIndicatorWidget(),
                            borderRadius: 12,
                            type: ProgressButtonType.Flat,
                            height: 56,
                            onPressed: () async {
                              userAthenticationController
                                  .isSignUpLoading.value = true;

                              _inputValidation();

                              // if (userAthenticationController
                              //         .signupPasswordController !=
                              //     userAthenticationController
                              //         .signupConfirmPasswordController) {
                              //   userAthenticationController
                              //       .isSignUpLoading.value = false;

                              //   Get.defaultDialog(
                              //       title: "In valid Password",
                              //       content: const Text(
                              //           "Password not matching please enter same password in comfirm pasword field"),
                              //       confirm: GestureDetector(
                              //           onTap: () {
                              //             Get.back();
                              //           },
                              //           child: const Text("ok")));
                              // } else {
                              //   userAthenticationController.signUP(
                              //       password: userAthenticationController
                              //           .signupPasswordController.text,
                              //       confirmPassword: userAthenticationController
                              //           .signupPasswordController.text,
                              //       email: userAthenticationController
                              //           .signupEmailController.text,
                              //       unitCode: userAthenticationController
                              //           .signupUnitCodeController.text,
                              //       phoneNumber: int.parse(
                              //           userAthenticationController
                              //               .signupPhoneNumberController.text),
                              //       userName: userAthenticationController
                              //           .signupUserNameController.text);
                              // }

                              //print()
                              //Get.to(() => const FacilityCode());
                            },
                          ),
                  ),

                  SizedBox(
                    height: 1.5 * SizeConfig.heightMultiplier,
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
                      Get.back();
                      //OneContext().pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _inputValidation() {
    if (_formKey.currentState.validate()) {
      userAthenticationController.signUP(
          password: userAthenticationController.signupPasswordController.text,
          confirmPassword:
              userAthenticationController.signupPasswordController.text,
          email: userAthenticationController.signupEmailController.text,
          unitCode: userAthenticationController.signupUnitCodeController.text,
          phoneNumber: int.parse(
              userAthenticationController.signupPhoneNumberController.text),
          userName: userAthenticationController.signupUserNameController.text);
    } else {
      userAthenticationController.isSignUpLoading.value = false;
    }
  }
}
