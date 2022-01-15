import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/guards_and_commitee_member_controller.dart';
import 'package:rapid_response/Model/pserson_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/progress_indicator_widget.dart';

import 'change_role.dart';

class TaskAssignScreen extends StatefulWidget {
  static String tag = 'task-page';

  @override
  _TaskAssignScreenScreenState createState() =>
      new _TaskAssignScreenScreenState();
}

class _TaskAssignScreenScreenState extends State<TaskAssignScreen> {
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context);
                  //Get.back();
                  //OneContext().pop();
                },
              ),
            ),
            title: Text(
              "Assign Tasks to",
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
                color: MyColors.grey_2,
                // alignment: Alignment.centerLeft,
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: GetX<GuardsandMemberController>(
                      init: Get.find<GuardsandMemberController>(),
                      builder: (controller) {
                        if (controller != null &&
                            controller.herlperList != null) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.herlperList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      Get.to(() => ChangeRoleScreen(
                                            userModel:
                                                controller.herlperList[index],
                                          ));
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        color: MyColors.white,
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            top: 16,
                                            right: 8,
                                            bottom: 16),
                                        child: Row(
                                          children: [
                                            Container(
                                                child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                height: 8 *
                                                    SizeConfig.heightMultiplier,
                                                width: 15 *
                                                    SizeConfig.widthMultiplier,
                                                imageUrl: controller
                                                    .herlperList[index].image,
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    const SmartDoubleBounceIndicatorWidget(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/images/profile-deleted.png',
                                                        fit: BoxFit.cover),
                                              ),
                                            )),
                                            // Container(
                                            //   margin: EdgeInsets.only(right: 8),
                                            //   height: 56,
                                            //   width: 56,
                                            //   alignment: Alignment.center,
                                            //   decoration: BoxDecoration(
                                            //       color: MyColors.primary,
                                            //       shape: BoxShape.circle),
                                            //   child: Image.asset(controller
                                            //       .herlperList[index]
                                            //       .roleImage ),
                                            // ),
                                            SizedBox(
                                              width: 2 *
                                                  SizeConfig.widthMultiplier,
                                            ),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text(
                                                    controller
                                                        .herlperList[index].name
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            MyColors.primary),
                                                  ),
                                                ),
                                                Container(
                                                    child: Row(
                                                  children: [
                                                    Image.asset(controller
                                                        .herlperList[index]
                                                        .roleImage
                                                        .trim()),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: Text(
                                                        controller
                                                            .herlperList[index]
                                                            .role,
                                                        style: const TextStyle(
                                                            color:
                                                                MyColors.grey),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            )),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8.0),
                                                height: 20,
                                                width: 20,
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: MyColors.grey,
                                                ),
                                              ),
                                            )
                                          ],
                                        )));
                              });
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
              )),
        ));
  }

  //TODO : Load Data from API
  List<Person> itemData = <Person>[
    Person('Andrew Parker', 'assets/images/profile-deleted.png', 'Guard',
        'assets/images/guard.png'),
    Person('Maximillian Jacobson', 'assets/images/profile-deleted.png',
        'Committee', 'assets/images/committee.png'),
    Person('Andrew Parker', 'assets/images/profile-deleted.png', 'Guard',
        'assets/images/guard.png'),
    Person('Maximillian Jacobson', 'assets/images/profile-deleted.png',
        'Committee', 'assets/images/committee.png'),
  ];
}
