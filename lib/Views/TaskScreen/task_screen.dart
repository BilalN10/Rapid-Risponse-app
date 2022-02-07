import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Model/task_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

import 'compnent/assign_task_screen.dart';

class TaskScreen extends StatefulWidget {
  static String tag = 'task-page';
  const TaskScreen({Key key}) : super(key: key);

  @override
  _TaskScreenScreenState createState() => _TaskScreenScreenState();
}

class _TaskScreenScreenState extends State<TaskScreen> {
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
                  //OneContext().pop();
                  Get.back();
                },
              ),
            ),
            title: const Text(
              "Tasks",
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
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => TaskAssignScreen());
                              //OneContext().pushNamed(Routes.assign_task_screen);
                            },
                            child: Container(
                                height: 10 * SizeConfig.heightMultiplier,
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, right: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      height: 40,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
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
                                            style: const TextStyle(
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
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                          'assets/images/clock-outline.png'),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 4),
                                                        child: Text(
                                                          itemData[index].date,
                                                          style: const TextStyle(
                                                              color: MyColors
                                                                  .grey),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        height: 16,
                                                        width: 16,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: MyColors
                                                                    .primary,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Image.asset(
                                                          'assets/images/warning-sign.png',
                                                          height: 10,
                                                          width: 10,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            itemData[index]
                                                                .status),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(left: 8.0),
                                        height: 20,
                                        width: 20,
                                        alignment: Alignment.center,
                                        child: const Icon(
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

  List<Task> itemData = <Task>[
    Task('Intruder / Tresspasser', 'Lorem ipsum sir dolor amet consequiteur...',
        '15s ago', 'Waiting Response', 'assets/images/warning-sign.png'),
    Task('Water Escaping', 'Lorem ipsum sir dolor amet consequiteur...',
        '11:23 am', 'Waiting Response', 'assets/images/water-escaping.png'),
    Task('Intruder / Tresspasser', 'Lorem ipsum sir dolor amet consequiteur...',
        '15s ago', 'Waiting Response', 'assets/images/warning-sign.png'),
    Task('Water Escaping', 'Lorem ipsum sir dolor amet consequiteur...',
        '11:23 am', 'Waiting Response', 'assets/images/water-escaping.png'),
    Task('Intruder / Tresspasser', 'Lorem ipsum sir dolor amet consequiteur...',
        '15s ago', 'Waiting Response', 'assets/images/warning-sign.png'),
    Task('Water Escaping', 'Lorem ipsum sir dolor amet consequiteur...',
        '11:23 am', 'Waiting Response', 'assets/images/water-escaping.png'),
  ];
}
