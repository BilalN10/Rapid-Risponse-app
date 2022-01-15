import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/progress_indicator_widget.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static String tag = 'profile-page';

  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      if (pickedImage != null) {
        userAthenticationController.image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
    File(pickedImage.path);
  }

  UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());
  // TextEditingController editname = TextEditingController();

  // TextEditingController editmail = TextEditingController();

  // TextEditingController editPhonenumber = TextEditingController();

  @override
  void initState() {
    userAthenticationController.getUser();
    super.initState();
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final name = Container(
    //   padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
    //   decoration: BoxDecoration(
    //       border: Border.all(color: MyColors.input_border),
    //       borderRadius: BorderRadius.circular(10.0)),
    //   child: TextFormField(
    //       initialValue: userAthenticationController.user.name,
    //       keyboardType: TextInputType.text,
    //       autofocus: false,
    //       decoration: InputDecoration(
    //           icon: Icon(
    //             Icons.person,
    //             color: Colors.grey.withOpacity(0.2),
    //           ),
    //           border: InputBorder.none,
    //           hintStyle: TextStyle(color: MyColors.hint),
    //           hintText: userAthenticationController.user.name),
    //       onChanged: (value) {}),
    // );
    // final username = Container(
    //   padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
    //   decoration: BoxDecoration(
    //       border: Border.all(color: MyColors.input_border),
    //       borderRadius: BorderRadius.circular(10.0)),
    //   child: TextFormField(
    //       initialValue: userAthenticationController.user.email,
    //       keyboardType: TextInputType.text,
    //       autofocus: false,
    //       decoration: InputDecoration(
    //           icon: Icon(
    //             Icons.person,
    //             color: Colors.grey.withOpacity(0.2),
    //           ),
    //           border: InputBorder.none,
    //           hintStyle: TextStyle(color: MyColors.hint),
    //           hintText: userAthenticationController.user.email),
    //       onChanged: (value) {}),
    // );

    // final phoneNumber = Container(
    //   padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
    //   decoration: BoxDecoration(
    //       border: Border.all(color: MyColors.input_border),
    //       borderRadius: BorderRadius.circular(10.0)),
    //   child: TextFormField(
    //       initialValue: userAthenticationController.user.phoneNumber,
    //       keyboardType: TextInputType.text,
    //       autofocus: false,
    //       decoration: InputDecoration(
    //           icon: Icon(
    //             Icons.phone_iphone_sharp,
    //             color: Colors.grey.withOpacity(0.2),
    //           ),
    //           border: InputBorder.none,
    //           hintStyle: TextStyle(color: MyColors.hint),
    //           hintText: userAthenticationController.user.phoneNumber),
    //       onChanged: (value) {}),
    // );

    final continueButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ProgressButton(
        color: MyColors.primary,
        defaultWidget: Container(
          child: Text(
            "Save Changes",
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        progressWidget: SmartButtonIndicatorWidget(),
        borderRadius: 12,
        type: ProgressButtonType.Flat,
        height: 56,
        onPressed: () async {
          userAthenticationController.isProfileChange.value = true;

          userAthenticationController.updateUserProfileData(
              email: userAthenticationController.editmail.text,
              name: userAthenticationController.editname.text,
              phoneNumber:
                  int.parse(userAthenticationController.editPhonenumber.text));
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
        },
      ),
    );

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
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
                  //OneContext().pop();
                },
              ),
            ),
            title: Text(
              "User Profile",
              style: TextStyle(
                  color: MyColors.grey_3, fontWeight: FontWeight.bold),
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
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: GetX<UserAthenticationController>(
                        init: Get.find<UserAthenticationController>(),
                        builder: (con) {
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5 * SizeConfig.heightMultiplier,
                              ),
                              Container(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      con.user.image != null
                                          ? Container(
                                              alignment: Alignment.center,
                                              height: 10 *
                                                  SizeConfig.heightMultiplier,
                                              width: 20 *
                                                  SizeConfig.widthMultiplier,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: userAthenticationController
                                                                  .image !=
                                                              null
                                                          ? FileImage(
                                                              userAthenticationController
                                                                  .image)
                                                          : NetworkImage(
                                                              userAthenticationController
                                                                  .user.image),
                                                      // userAthenticationController
                                                      //             .image !=

                                                      // ? FileImage(
                                                      //     userAthenticationController
                                                      //         .image)

                                                      fit: BoxFit.cover),
                                                  color: Colors.white),
                                            )
                                          : CircularProgressIndicator(),
                                      // Container(
                                      //     child: ClipRRect(
                                      //   borderRadius:
                                      //       BorderRadius.circular(250),
                                      //   child: CachedNetworkImage(
                                      //     imageUrl: '',
                                      //     fit: BoxFit.cover,
                                      //     progressIndicatorBuilder: (context,
                                      //             url, downloadProgress) =>
                                      //         SmartDoubleBounceIndicatorWidget(),
                                      //     errorWidget: (context, url, error) =>
                                      //         Image.asset(
                                      //             'assets/images/profile-deleted.png',
                                      //             fit: BoxFit.cover),
                                      //   ),
                                      // )),
                                      SizedBox(
                                        height: 0 * SizeConfig.heightMultiplier,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          child: const Text(
                                            'Enter your name and add an optional profile picture',
                                            style:
                                                TextStyle(color: MyColors.grey),
                                          )))
                                ],
                              )),
                              const SizedBox(height: 10.0),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 4 * SizeConfig.widthMultiplier),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: Text('Edit')),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3 * SizeConfig.heightMultiplier),

                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 12.0, right: 12.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Profile Infos:',
                                        style: TextStyle(
                                            color: MyColors.secondary,
                                            fontWeight: FontWeight.bold)),
                                  )),
                              SizedBox(height: 16.0),
                              Container(
                                padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColors.input_border),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextFormField(
                                    controller:
                                        userAthenticationController.editmail,
                                    //initialValue: con.user.email,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: MyColors.hint),
                                        hintText: con.user.email),
                                    onChanged: (value) {}),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColors.input_border),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextFormField(
                                    controller: userAthenticationController
                                        .editPhonenumber,
                                    //initialValue: con.user.phoneNumber,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.phone_iphone_sharp,
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: MyColors.hint),
                                        hintText: con.user.phoneNumber),
                                    onChanged: (value) {}),
                              ),

                              SizedBox(height: 5.0),
                              Container(
                                padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColors.input_border),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextFormField(
                                    controller:
                                        userAthenticationController.editname,
                                    // initialValue: con.user.name,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.person,
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: MyColors.hint),
                                        hintText: con.user.name),
                                    onChanged: (value) {}),
                              ),
                              SizedBox(height: 5.0),
                              //phoneNumber,
                              SizedBox(height: 16.0),
                              // DropdownSearch<String>(
                              //     hint: "Guard",
                              //     mode: Mode.BOTTOM_SHEET,
                              //     showSearchBox: true,
                              //     searchBoxDecoration: const InputDecoration(
                              //       focusedBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Colors.grey, width: 0.4),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Colors.grey, width: 0.4),
                              //       ),
                              //       labelText: "Guard",
                              //     ),
                              //     items: ['Guard'],
                              //     // selectedItem: _store.skpd,
                              //     showClearButton: true,
                              //     onChanged: (value) {}),
                              const SizedBox(height: 16.0),
                              con.isProfileChange.value
                                  ? const CircularProgressIndicator()
                                  : continueButton,
                            ],
                          );
                        }),
                  ),
                ),
              )),
        ));
  }
}
