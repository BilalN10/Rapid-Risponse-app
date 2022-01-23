import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/notifiaciton_for_approve_account_controller.dart';
import 'package:rapid_response/Model/notification_for_approve_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Constants/mydialog.dart';
import 'package:rapid_response/Views/Rapid_Response/Components/rappid_response_dialog.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class PendingAccountDettail extends StatelessWidget {
  final NotificationForApproveModel notificationForApproveModel;
  PendingAccountDettail({Key key, this.notificationForApproveModel});
  final NotificationForApprovrAccount notificationForApprovrAccount =
      Get.put(NotificationForApprovrAccount());

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
            "Pending Request",
            //style:simplestyle()
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Center(
              child: Container(
                height: 50 * SizeConfig.heightMultiplier,
                width: 80 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.black12)
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            "Role",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            "Phone Number",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            "Unit Code",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notificationForApproveModel.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            notificationForApproveModel.email,
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            notificationForApproveModel.role,
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            notificationForApproveModel.phoneNumber.toString(),
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                          Text(
                            notificationForApproveModel.unitCode,
                            style: TextStyle(
                              fontSize: 1.5 * SizeConfig.textMultiplier,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 35 * SizeConfig.widthMultiplier,
                  child: ProgressButton(
                    color: MyColors.grey,
                    defaultWidget: Container(
                      child: Text(
                        "Cancel",
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
                      Get.back();
                      //     .googleSignout();
                      //Get.to(() => const FacilityCode());
                    },
                  ),
                ),
                Container(
                  width: 35 * SizeConfig.widthMultiplier,
                  child: ProgressButton(
                    color: MyColors.primary,
                    defaultWidget: Container(
                      child: Text(
                        "Approve account",
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
                      // MyDialog.doubleButtonDailog(
                      //     cancelbuttonText: "NO",
                      //     confirmbuttonText: "Yes",
                      //     middleText: "Do you want to approve this account",
                      //     title: "Account Approve",
                      //     onCancelfunction: () {
                      //       OneContext().popDialog();
                      //     },
                      //     onCofirmfunction: (){

                      //     }
                      //     );
                      if (notificationForApproveModel.isApproved) {
                        MyDialog.sigleButtonDailog(
                            buttonText: "OK",
                            middleText: "This account is already approved",
                            title: "Account Approved",
                            function: () {
                              OneContext().popDialog();
                            });
                      } else {
                        notificationForApprovrAccount.approveAccount(
                            notificationForApproveModel.userId,
                            notificationForApproveModel.tokanId,
                            notificationForApproveModel.notificatinId);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
