import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/notifiaciton_for_approve_account_controller.dart';
import 'package:rapid_response/Model/notification_for_approve_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/NotificationForApproveAccount/pending_account_detail.dart';

class ApporveNotificationScreen extends StatelessWidget {
  ApporveNotificationScreen({Key key}) : super(key: key);
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
          "Notification",
          //style:simplestyle()
        ),
      ),
      body: Container(
        height: 90 * SizeConfig.heightMultiplier,
        width: 100 * SizeConfig.screenWidth,
        child: GetX<NotificationForApprovrAccount>(
            init: Get.put(NotificationForApprovrAccount()),
            builder: (con) {
              if (con != null && con.getnotificationForApproveList != null) {
                return ListView.builder(
                    itemCount: con.getnotificationForApproveList.length,
                    itemBuilder: (context, index) {
                      con.isAccountApproved(
                          con.getnotificationForApproveList[index].userId);
                      return GestureDetector(
                        onTap: () {
                          // print(con
                          //     .getnotificationForApproveList[index].isApproved);
                          //notificationForApproveModel.isApproved;
                          Get.to(() => PendingAccountDettail(
                                notificationForApproveModel:
                                    con.getnotificationForApproveList[index],
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          height: 10 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 10),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.notification_important_rounded,
                                      size: 5 * SizeConfig.imageSizeMultiplier,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      con.getnotificationForApproveList[index]
                                          .notificationtitle,
                                      style: TextStyle(
                                        fontSize:
                                            1.8 * SizeConfig.textMultiplier,
                                        color: MyColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 4 * SizeConfig.heightMultiplier,
                                  width: 80 * SizeConfig.widthMultiplier,
                                  child: Text(
                                    con.getnotificationForApproveList[index]
                                        .notificationBody,
                                    style: TextStyle(
                                      fontSize: 1.5 * SizeConfig.textMultiplier,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    con.getnotificationForApproveList[index]
                                            .isApproved
                                        ? Text(
                                            "Account approved",
                                            style: TextStyle(
                                                fontSize: 1.4 *
                                                    SizeConfig.textMultiplier),
                                          )
                                        : Text(
                                            "Account not approve",
                                            style: TextStyle(
                                                color: MyColors.primary,
                                                fontSize: 1.4 *
                                                    SizeConfig.textMultiplier),
                                          )
                                  ],
                                )
                                // con.getnotificationForApproveList[index]
                                //         .isApproved
                                //     ? Text("Approved")
                                //     : Text("Pending"),
                              ],
                            ),
                          ),
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
