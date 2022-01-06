import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/chat_controller.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class DoctorMessage extends StatefulWidget {
  final String availableStatus;
  DoctorMessage({this.availableStatus});

  // final UserModel userModel;
  /// DoctorMessage({this.userModel});
  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<DoctorMessage> {
  UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();
  ChatController chatController = Get.put(ChatController());
  @override
  void initState() {
    userAthenticationController.checkIsEventClosed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: MyColors.primary,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                // color: kLightyellow,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Broadcast Chat",
              //style:simplestyle()
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        chatController.isAvailable.value =
                            !chatController.isAvailable.value;
                      },
                      child: Text(
                        "Available",
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Obx(() => userAthenticationController.isEventClose.value
              ? Container(
                  height: 90 * SizeConfig.heightMultiplier,
                  width: 100 * SizeConfig.widthMultiplier,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "This Event is closed",
                        style:
                            TextStyle(fontSize: 3 * SizeConfig.textMultiplier),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        height: 5 * SizeConfig.heightMultiplier,
                        width: 25 * SizeConfig.widthMultiplier,
                        child: ProgressButton(
                          color: MyColors.primary,
                          defaultWidget: Container(
                            child: Text(
                              "GO Back",
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
                            userAthenticationController.isResponding.value =
                                false;
                            Get.back();
                            //userAthenticationController.closeEvent();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 90 * SizeConfig.heightMultiplier,
                        child: Container(
                          height: SizeConfig.heightMultiplier * 80,
                          width: SizeConfig.screenWidth,
                          child: GetX<ChatController>(
                              init: Get.find<ChatController>(),
                              builder: (chatController) {
                                if (chatController != null &&
                                    chatController.getchatList != null) {
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          chatController.getchatList.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index !=
                                            chatController.getchatList.length) {
                                          return Stack(
                                            alignment:
                                                userAthenticationController
                                                            .users.uid ==
                                                        chatController
                                                            .getchatList[index]
                                                            .senderId
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                            children: [
                                              Column(
                                                children: [
                                                  // SizedBox(
                                                  //   height: 6 *
                                                  //       SizeConfig
                                                  //           .heightMultiplier,
                                                  // ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        userAthenticationController
                                                                    .users
                                                                    .uid ==
                                                                chatController
                                                                    .getchatList[
                                                                        index]
                                                                    .senderId
                                                            ? CrossAxisAlignment
                                                                .end
                                                            : CrossAxisAlignment
                                                                .start,
                                                    children: [
                                                      index == 0
                                                          ? SizedBox(
                                                              height: 7 *
                                                                  SizeConfig
                                                                      .heightMultiplier,
                                                            )
                                                          : SizedBox(),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  MyColors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          // alignment: userAthenticationController
                                                          //             .users.uid ==
                                                          //         chatController
                                                          //             .getchatList[index]
                                                          //             .senderId
                                                          //     ? Alignment.centerRight
                                                          //     : Alignment.centerLeft,
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 40 *
                                                                SizeConfig
                                                                    .widthMultiplier,
                                                            // maxHeight: 8 *
                                                            //     SizeConfig.heightMultiplier,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${chatController.getchatList[index].name} (${chatController.getchatList[index].satus} )"),
                                                                Text(chatController
                                                                    .getchatList[
                                                                        index]
                                                                    .txtMessage),
                                                              ],
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              userAthenticationController
                                                              .eventCreaterUid
                                                              .value ==
                                                          userAthenticationController
                                                              .users.uid &&
                                                      index == 0
                                                  ? Positioned(
                                                      top: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container(
                                                          width: 90 *
                                                              SizeConfig
                                                                  .widthMultiplier,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Do you want to close this event "),
                                                                  Container(
                                                                    height: 5 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                    width: 25 *
                                                                        SizeConfig
                                                                            .widthMultiplier,
                                                                    child:
                                                                        ProgressButton(
                                                                      color: MyColors
                                                                          .primary,
                                                                      defaultWidget:
                                                                          Container(
                                                                        child:
                                                                            Text(
                                                                          "Close Event",
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          style: TextStyle(
                                                                              fontSize: 1.6 * SizeConfig.textMultiplier,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      progressWidget:
                                                                          const SmartButtonIndicatorWidget(),
                                                                      borderRadius:
                                                                          12,
                                                                      type: ProgressButtonType
                                                                          .Flat,
                                                                      height:
                                                                          56,
                                                                      onPressed:
                                                                          () async {
                                                                        userAthenticationController
                                                                            .closeEvent();
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          );
                                        } else {
                                          return SizedBox(
                                            height:
                                                8 * SizeConfig.heightMultiplier,
                                          );
                                        }
                                      });
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                        ),
                      ),
                      Obx(() => chatController.isAvailable.value
                          ? Container(
                              height: 40 * SizeConfig.heightMultiplier,
                              width: 100 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(color: MyColors.grey),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3 * SizeConfig.heightMultiplier,
                                  ),
                                  Text(
                                    "Availabel Responder",
                                    style: TextStyle(
                                      color: MyColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2 * SizeConfig.textMultiplier,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2 * SizeConfig.heightMultiplier,
                                  ),
                                  GetX<ChatController>(
                                      init: Get.find<ChatController>(),
                                      builder: (chatController) {
                                        return GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 10,
                                            //mainAxisExtent:
                                          ),
                                          itemCount: chatController
                                              .grtAvailableRespoderList.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 7 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  width: 40 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "${chatController.grtAvailableRespoderList[index].responderName.toUpperCase()} has seleced  ${chatController.grtAvailableRespoderList[index].status}",
                                                          maxLines: 3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                ],
                              ))
                          : SizedBox()),
                      Positioned(
                        bottom: 1,
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.file_present,
                                        // color: kLightyellow,
                                      ))),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.camera_alt_sharp,
                                        // color: kLightyellow,
                                      ))),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextFormField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: userAthenticationController
                                      .messageController,
                                  decoration: InputDecoration(
                                      hintText: "Enter message",
                                      contentPadding: const EdgeInsets.only(
                                          top: 5, bottom: 5, left: 5),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      )),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: IconButton(
                                      onPressed: () {
                                        if (userAthenticationController
                                            .messageController
                                            .text
                                            .isNotEmpty) {
                                          userAthenticationController
                                              .sendMessage(
                                                  userAthenticationController
                                                      .messageController.text,
                                                  widget.availableStatus);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        //  color: kLightyellow,
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
    );
  }

  Container senderMessage(BuildContext cntxt, String path, String message,
      double width, double height) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 30, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black),
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: CircleAvatar(
              backgroundImage: AssetImage(path),
            ),
          ),
        ],
      ),
    );
  }

  Container messageList(BuildContext context, String path, String doctorName,
      String message, String time,
      {int DoctorMessage}) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: Row(
        children: [
          Container(
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(path),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 10),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: Text(doctorName)),
                Text(
                  message,
                  style: TextStyle(color: Colors.grey[400]),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    time,
                    style: TextStyle(
                        //color: kLightyellow,
                        ),
                  ),
                ),
                Container(
                    // width: 20,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        // color:
                        //     DoctorMessage != null ? kLightyellow : Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: DoctorMessage != null
                            ? Text(DoctorMessage.toString())
                            : null))
              ],
            ),
          )
        ],
      ),
    );
  }

  Container receiver(BuildContext cntxt, String img, String message,
      double height, double width) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 30),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage(img),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                height: height,
                width: width,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    //  color: kLightyellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
