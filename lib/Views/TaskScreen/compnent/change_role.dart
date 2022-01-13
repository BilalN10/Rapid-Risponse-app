import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/user_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Rapid_Response/Components/rappid_response_dialog.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/progress_indicator_widget.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class ChangeRoleScreen extends StatefulWidget {
  final UserModel userModel;
  ChangeRoleScreen({Key key, this.userModel}) : super(key: key);
  static const Map<String, int> frequencyOptions = {
    "Guard": 222,
    "Comitee Members": 333,
    "All": 000,
    "Resident": 444,
  };

  @override
  State<ChangeRoleScreen> createState() => _ChangeRoleScreenState();
}

class _ChangeRoleScreenState extends State<ChangeRoleScreen> {
  UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());
  // int _frequencyValue = 000;
  int _frequencyValue;
  @override
  void initState() {
    super.initState();
    setState(() {
      print("assign number is ${widget.userModel.assignNumber}");
      _frequencyValue = widget.userModel.assignNumber;
    });
    print("frequescy is $_frequencyValue");

    userAthenticationController.updateValue(widget.userModel.assignNumber);
    // print(user)
  }

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
      body: Column(
        children: [
          Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              height: 8 * SizeConfig.heightMultiplier,
              width: 15 * SizeConfig.widthMultiplier,
              imageUrl: widget.userModel.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const SmartDoubleBounceIndicatorWidget(),
              errorWidget: (context, url, error) => Image.asset(
                  'assets/images/profile-deleted.png',
                  fit: BoxFit.cover),
            ),
          )),
          infoTile(
              tile: "Name", description: widget.userModel.name.toUpperCase()),
          infoTile(tile: "Email", description: widget.userModel.email),
          infoTile(
              tile: "Phone Number", description: widget.userModel.phoneNumber),
          infoTile(tile: "Unit Code", description: widget.userModel.uniCode),
          //  infoTile(tile: "Role", description: widget.userModel.role),
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: 8 * SizeConfig.heightMultiplier,
              width: 100 * SizeConfig.widthMultiplier,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyColors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 12 * SizeConfig.widthMultiplier),
                    child: Text("Role"),
                  ),
                  // SizedBox(
                  //   width: 7 * SizeConfig.widthMultiplier,
                  // ),
                  Container(
                    height: 8 * SizeConfig.heightMultiplier,
                    width: 50 * SizeConfig.widthMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(color: Colors.grey)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<int>(
                        alignment: Alignment.topRight,

                        // isExpanded: true,
                        underline: SizedBox(),
                        items: ChangeRoleScreen.frequencyOptions
                            .map((description, value) {
                              print(description);
                              return MapEntry(
                                  description,
                                  DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(description),
                                  ));
                            })
                            .values
                            .toList(),
                        value: _frequencyValue,
                        onChanged: (int newValue) {
                          if (newValue != null) {
                            setState(() {
                              print(
                                  "role ${ChangeRoleScreen.frequencyOptions}");

                              print(newValue);
                              _frequencyValue = newValue;

                              Get.defaultDialog(
                                  confirm: GestureDetector(
                                    onTap: () {
                                      userAthenticationController.changeRole(
                                          widget.userModel.id, _frequencyValue);
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: MyColors.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  cancel: GestureDetector(
                                      onTap: () {
                                        OneContext().popDialog();
                                      },
                                      child: Text("Cancel")),
                                  title: "Change Role",
                                  middleText:
                                      "Do you want to change this role");
                            });
                          }
                          // userAthenticationController
                          //     .sendAlertDialog(_frequencyValue);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       width: 47 * SizeConfig.widthMultiplier,
          //       child: ProgressButton(
          //         color: MyColors.primary,
          //         defaultWidget: Container(
          //           child: Text(
          //             "Change Role",
          //             textAlign: TextAlign.right,
          //             style: TextStyle(
          //                 fontSize: 1.6 * SizeConfig.textMultiplier,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.white),
          //           ),
          //         ),
          //         progressWidget: const SmartButtonIndicatorWidget(),
          //         borderRadius: 12,
          //         type: ProgressButtonType.Flat,
          //         height: 56,
          //         onPressed: () async {
          //           // Get.defaultDialog(title: "Change Role", actions: [
          //           //   Container(
          //           //     height: 8 * SizeConfig.heightMultiplier,
          //           //     width: 90 * SizeConfig.widthMultiplier,
          //           //     decoration: BoxDecoration(
          //           //         borderRadius: BorderRadius.circular(8),
          //           //         border: Border.all(color: Colors.grey)),
          //           //     child: Padding(
          //           //         padding: const EdgeInsets.all(8.0),
          //           //         child: Obx(
          //           //           () => DropdownButton<int>(
          //           //             isExpanded: true,
          //           //             underline: SizedBox(),
          //           //             items: ChangeRoleScreen.frequencyOptions
          //           //                 .map((description, value) {
          //           //                   return MapEntry(
          //           //                       description,
          //           //                       DropdownMenuItem<int>(
          //           //                         value: value,
          //           //                         child: Text(description),
          //           //                       ));
          //           //                 })
          //           //                 .values
          //           //                 .toList(),
          //           //             value: _frequencyValue,
          //           //             onChanged: (int newValue) {
          //           //               if (newValue != null) {
          //           //                 setState(() {
          //           //                   print(newValue);
          //           //                   userAthenticationController
          //           //                       .frequencyValue.value = newValue;
          //           //                 });
          //           //               }
          //           //               // userAthenticationController
          //           //               //     .sendAlertDialog(_frequencyValue);
          //           //             },
          //           //           ),
          //           //         )),
          //           //   ),
          //           // ]);
          //         },
          //       ),
          //     ),
          //   ],
          // )
          // infoTile(
          //     tile: "Assign Number",
          //     description: userModel.assignNumber.toString()),
          // Padding(
          //   padding: EdgeInsets.all(10),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Note",
          //         style: TextStyle(
          //             color: MyColors.primary,
          //             fontSize: 2 * SizeConfig.textMultiplier,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         " * You can Change here only role and assign number.",
          //         style: TextStyle(
          //           color: MyColors.primary,
          //           fontSize: 1.3 * SizeConfig.textMultiplier,
          //           //fontWeight: FontWeight.bold
          //         ),
          //       ),

          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget infoTile({String tile, String description}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          height: 8 * SizeConfig.heightMultiplier,
          width: 100 * SizeConfig.widthMultiplier,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(tile),
              Text(":"),
              Text(description),
            ],
          )),
    );
  }
}
