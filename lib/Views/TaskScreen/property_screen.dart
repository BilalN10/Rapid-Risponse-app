import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/guards_and_commitee_member_controller.dart';
import 'package:rapid_response/Model/notification_for_approve_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

import 'compnent/assign_task_screen.dart';

class PropertyScreen extends StatelessWidget {
  PropertyScreen({Key key}) : super(key: key);
  final NotificationForApproveModel notificationForApproveModel =
      NotificationForApproveModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.primary,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            // color: kLightyellow,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Generated Property",
          //style:simplestyle()
        ),
      ),
      body: Container(
        height: 90 * SizeConfig.heightMultiplier,
        width: 100 * SizeConfig.screenWidth,
        child: GetX<GuardsandMemberController>(
            init: Get.put(GuardsandMemberController()),
            builder: (con) {
              if (con != null && con.getGeneratedPropertyList != null) {
                return ListView.builder(
                    itemCount: con.getGeneratedPropertyList.length,
                    itemBuilder: (context, index) {
                      // con.isAccountApproved(
                      //     con.getnotificationForApproveList[index].userId);
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => TaskAssignScreen(
                                userInfoID: con.getGeneratedPropertyList[index]
                                    .propertyCode,
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          height: 15 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 10),
                              ]),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Property Code"),
                                      Text("City"),
                                      Text("Provicy"),
                                      Text("Postal code"),
                                      Text("Adress"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(":"),
                                      Text(":"),
                                      Text(":"),
                                      Text(":"),
                                      Text(":"),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(con.getGeneratedPropertyList[index]
                                          .propertyCode),
                                      Text(con.getGeneratedPropertyList[index]
                                          .city),
                                      Text(con.getGeneratedPropertyList[index]
                                          .provnice),
                                      Text(con.getGeneratedPropertyList[index]
                                          .postalCode),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        // color: Colors.amber,
                                        height: 3 * SizeConfig.heightMultiplier,
                                        width: 15 * SizeConfig.heightMultiplier,
                                        child: Text(
                                          con.getGeneratedPropertyList[index]
                                              .address,
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
