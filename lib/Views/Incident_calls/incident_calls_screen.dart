import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Model/incident_calls_Model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

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
                  Get.back();
                  //OneContext().pop();
                },
              ),
            ),
            title: Text(
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
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            child: Container(
                                height: 8 * SizeConfig.heightMultiplier,
                                padding:
                                    EdgeInsets.only(left: 16, top: 8, right: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        itemData[index].image,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            itemData[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.primary),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child:
                                              Text(itemData[index].description),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                height: 16,
                                                width: 16,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: MyColors.grey_2,
                                                    shape: BoxShape.circle),
                                                child: Text(
                                                  itemData[index]
                                                      .responders
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: itemData[index]
                                                                  .responders >
                                                              0
                                                          ? MyColors.black
                                                          : MyColors.grey),
                                                ),
                                              ),
                                              Text(
                                                'Responders',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: itemData[index]
                                                                .responders >
                                                            0
                                                        ? MyColors.black
                                                        : MyColors.grey),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(left: 8.0),
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
