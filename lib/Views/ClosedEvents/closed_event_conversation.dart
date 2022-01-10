import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:rapid_response/Controller/chat_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

class ClosedEventConversation extends StatefulWidget {
  final DocumentReference documentReference;
  ClosedEventConversation({Key key, this.documentReference});

  @override
  State<ClosedEventConversation> createState() =>
      _ClosedEventConversationState();
}

class _ClosedEventConversationState extends State<ClosedEventConversation> {
  final ChatController chatController = Get.put(ChatController());
  @override
  void initState() {
    chatController.callClosedEventConversation(widget.documentReference);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Closed Event",
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
                    chatController.isAvailableClosed.value =
                        !chatController.isAvailableClosed.value;
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
      body: Stack(
        children: [
          Container(
            height: 90 * SizeConfig.heightMultiplier,
            width: 100 * SizeConfig.heightMultiplier,
            //color: Colors.red,
            child: GetX<ChatController>(
                init: Get.put(ChatController()),
                builder: (chatController) {
                  if (chatController != null &&
                      chatController.getClosedEventConversation != null) {
                    return ListView.builder(
                        itemCount:
                            chatController.getClosedEventConversation.length,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                  color: MyColors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(10),
                              // alignment: userAthenticationController
                              //             .users.uid ==
                              //         chatController
                              //             .getchatList[index]
                              //             .senderId
                              //     ? Alignment.centerRight
                              //     : Alignment.centerLeft,
                              constraints: BoxConstraints(
                                maxWidth: 40 * SizeConfig.widthMultiplier,
                                // maxHeight: 8 *
                                //     SizeConfig.heightMultiplier,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${chatController.getClosedEventConversation[index].name} (${chatController.getClosedEventConversation[index].satus} )"),
                                    Text(chatController
                                        .getClosedEventConversation[index]
                                        .txtMessage),
                                  ],
                                ),
                              ));

                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Container(
                          //     alignment: Alignment.centerLeft,
                          //     margin: EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //         color: Colors.red,
                          //         borderRadius: BorderRadius.circular(10)),
                          //     height: 8 * SizeConfig.heightMultiplier,
                          //     width: 100 * SizeConfig.widthMultiplier,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child:
                          //       //  Column(
                          //       //     mainAxisAlignment: MainAxisAlignment.center,
                          //       //     children: [
                          //       //       Text(chatController
                          //       //           .getClosedEventConversation[index]
                          //       //           .txtMessage)

                          //       //       // Obx(() => Text(chatController.eventTit)),
                          //       //     ]),
                          //     ),
                          //   ),
                          // );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
          Obx(() => chatController.isAvailableClosed.value
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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10,
                                //mainAxisExtent:
                              ),
                              itemCount: chatController
                                  .getClosedEventclosedEventResponder.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 7 * SizeConfig.heightMultiplier,
                                      width: 40 * SizeConfig.widthMultiplier,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${chatController.getClosedEventclosedEventResponder[index].responderName.toUpperCase()} has seleced  ${chatController.getClosedEventclosedEventResponder[index].status}",
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
        ],
      ),
    );
  }
}
