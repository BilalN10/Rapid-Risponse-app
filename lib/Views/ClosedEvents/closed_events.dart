import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/chat_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/ClosedEvents/closed_event_Conversation.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

class ClosedEventsScreen extends StatelessWidget {
  ClosedEventsScreen({Key key}) : super(key: key);

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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         GestureDetector(
        //           onTap: () {},
        //           child: Text(
        //             "Available",
        //             style: TextStyle(
        //                 fontSize: 2 * SizeConfig.heightMultiplier,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ],
      ),
      body: Container(
        height: 90 * SizeConfig.heightMultiplier,
        width: 100 * SizeConfig.heightMultiplier,
        //color: Colors.red,
        child: GetX<ChatController>(
            init: Get.put(ChatController()),
            builder: (chatController) {
              if (chatController != null &&
                  chatController.getChatReferance != null) {
                return ListView.builder(
                    itemCount: chatController.getChatReferance.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ClosedEventConversation(
                                documentReference: chatController
                                    .getChatReferance[index].documentReference,
                              ));
                          // chatController.callClosedEventConversation(
                          //     chatController
                          //         .getChatReferance[index].documentReference);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.black12
                                    //offset: Offset(2, )
                                    )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 8 * SizeConfig.heightMultiplier,
                          width: 100 * SizeConfig.widthMultiplier,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => Text(chatController
                                      .getChatReferance[index].eventTitle.value
                                      .toUpperCase()))

                                  // Obx(() => Text(chatController.eventTit)),
                                ]),
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
