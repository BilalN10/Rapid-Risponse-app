import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/incident_call_contoller.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/incident_calls_Model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Rapid_Response/rapid_response.dart';

class IncidentCallsScreen extends StatefulWidget {
  static String tag = 'IncidentCalls-page';

  @override
  _IncidentCallsScreenState createState() => new _IncidentCallsScreenState();
}

class _IncidentCallsScreenState extends State<IncidentCallsScreen> {
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();
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
              margin: const EdgeInsets.only(left: 16.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.bg_button_back,
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(
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
            title: const Text(
              "Incident Calls",
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
                height: SizeConfig.screenHeight,
                // alignment: Alignment.centerLeft,
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: GetX<IncidentCallController>(
                      init: Get.put(IncidentCallController()),
                      builder: (incidentCallController) {
                        if (incidentCallController != null &&
                            incidentCallController.getNotificationList !=
                                null) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: incidentCallController
                                  .getNotificationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      userAthenticationController.chatID =
                                          incidentCallController
                                              .getNotificationList[index]
                                              .chatID;
                                      print(userAthenticationController.chatID);
                                      userAthenticationController
                                              .eventCreatorId =
                                          incidentCallController
                                              .getNotificationList[index]
                                              .eventCreatorId;

                                      OneContext().showDialog(
                                          builder: (BuildContext context) {
                                        return Dialog(
                                          insetAnimationCurve:
                                              Curves.linearToEaseOut,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            height: 20 *
                                                SizeConfig.heightMultiplier,
                                            width:
                                                10 * SizeConfig.widthMultiplier,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2 *
                                                      SizeConfig
                                                          .heightMultiplier),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    incidentCallController
                                                        .getNotificationList[
                                                            index]
                                                        .notificationTite
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 2 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            MyColors.primary),
                                                  ),
                                                  Text(
                                                    "Do you want to response this calls",
                                                    style: TextStyle(
                                                      fontSize: 1.5 *
                                                          SizeConfig
                                                              .textMultiplier,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      //color: MyColors.primary
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            OneContext()
                                                                .popDialog();
                                                          },
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              color: MyColors
                                                                  .primary,
                                                              fontSize: 1.5 *
                                                                  SizeConfig
                                                                      .textMultiplier,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              //color: MyColors.primary
                                                            ),
                                                          )),
                                                      GestureDetector(
                                                          onTap: () {
                                                            OneContext()
                                                                .popDialog();

                                                            userAthenticationController
                                                                .isResponding
                                                                .value = true;

                                                            Get.offAll(() =>
                                                                RapidResponseScreen(
                                                                  isRespospoding:
                                                                      true,
                                                                ));
                                                            // OneContext()
                                                            //     .popDialog();
                                                          },
                                                          child: Text(
                                                            "Confirm",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 1.5 *
                                                                  SizeConfig
                                                                      .textMultiplier,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              //color: MyColors.primary
                                                            ),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );

                                        // Container(
                                        //   height: 100,
                                        //   width: 100,
                                        //   color: Colors.white,
                                        //   child: Column(
                                        //     children: [Text("hi")],
                                        //   ),
                                        // );
                                      });
                                      // Get.defaultDialog(
                                      //     middleText:
                                      //         "Do you want to response this calls",
                                      //     title: incidentCallController
                                      //         .getNotificationList[index]
                                      //         .notificationTite
                                      //         .toUpperCase(),
                                      //     // content: Container(
                                      //     //   child: Text(
                                      //     //       "Do you want to response this calls"),
                                      //     // )
                                      //     actions: [
                                      //       Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.spaceAround,
                                      //         children: [
                                      //           GestureDetector(
                                      //             onTap: () {
                                      //               Get.back();
                                      //             },
                                      //             child: Text(
                                      //               "No",
                                      //               style: TextStyle(
                                      //                   color: Colors.red),
                                      //             ),
                                      //           ),
                                      //           GestureDetector(
                                      //             onTap: () {
                                      //               Get.back();
                                      //               Get.to(() =>
                                      //                   RapidResponseScreen(
                                      //                     isRespospoding: true,
                                      //                   ));
                                      //             },
                                      //             child: Text(
                                      //               "Yes",
                                      //               style: TextStyle(
                                      //                   color: Colors.green),
                                      //             ),
                                      //           )
                                      //         ],
                                      //       )
                                      //     ]);
                                    },
                                    child: Container(
                                        //height: 8 * SizeConfig.heightMultiplier,
                                        padding: EdgeInsets.only(
                                            left: 16, top: 8, right: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 8),
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: MyColors.primary,
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                "assets/images/alerts.png",
                                                color: Colors.white,
                                              ),
                                            ),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text(
                                                    incidentCallController
                                                        .getNotificationList[
                                                            index]
                                                        .notificationTite
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            MyColors.primary),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  child: Text(
                                                      incidentCallController
                                                          .getNotificationList[
                                                              index]
                                                          .notificaitonBody),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 4),
                                                            height: 16,
                                                            width: 16,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: MyColors
                                                                    .grey_2,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Text(
                                                              incidentCallController
                                                                  .getNotificationList[
                                                                      index]
                                                                  .responders
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: incidentCallController
                                                                              .getNotificationList[
                                                                                  index]
                                                                              .responders >
                                                                          0
                                                                      ? MyColors
                                                                          .black
                                                                      : MyColors
                                                                          .grey),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Responders',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: incidentCallController
                                                                            .getNotificationList[
                                                                                index]
                                                                            .responders >
                                                                        0
                                                                    ? MyColors
                                                                        .black
                                                                    : MyColors
                                                                        .grey),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        incidentCallController
                                                            .getNotificationList[
                                                                index]
                                                            .date,
                                                        style: TextStyle(
                                                            fontSize: 1.5 *
                                                                SizeConfig
                                                                    .textMultiplier),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Divider()
                                              ],
                                            )),
                                            // Align(
                                            //   alignment:
                                            //       AlignmentDirectional.center,
                                            //   child: Container(
                                            //     margin: const EdgeInsets.only(
                                            //         left: 8.0),
                                            //     height: 20,
                                            //     width: 20,
                                            //     alignment: Alignment.center,
                                            //     child: Icon(
                                            //       Icons.keyboard_arrow_right,
                                            //       color: MyColors.grey,
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        )));
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
              )),
        ));
  }

  //TODO : Load Data from API
  List<IncidentCalls> itemData = <IncidentCalls>[
    IncidentCalls(
        'Medical Emergency',
        'Lorem ipsum sir dolor amet consequiteur...',
        3,
        'assets/images/medical-emergency.png'),
    IncidentCalls(
        'Medical Emergency',
        'Lorem ipsum sir dolor amet consequiteur...',
        0,
        'assets/images/medical-emergency.png'),
    IncidentCalls(
        'Water Escaping',
        'Lorem ipsum sir dolor amet consequiteur...',
        2,
        'assets/images/water-escaping.png'),
    IncidentCalls(
        'Intruder / Tresspasser',
        'Lorem ipsum sir dolor amet consequiteur...',
        5,
        'assets/images/warning-sign.png'),
  ];
}
