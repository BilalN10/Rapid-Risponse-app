import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

class DoctorMessage extends StatefulWidget {
  // final UserModel userModel;
  /// DoctorMessage({this.userModel});
  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<DoctorMessage> {
  UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
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
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: const AssetImage(
                    "assets/images/account.png",
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "Tawfeeq Bahri",
                      //style:simplestyle()
                    ))
              ],
            ),
          ),
          body: Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: SizeConfig.screenHeight,
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              // color: Colors.amber
                              ),
                        )

                        // receiver(
                        //   context,
                        //   "assets/images/account.png",
                        //   "Hello",
                        //   MediaQuery.of(context).size.height * 0.047,
                        //   MediaQuery.of(context).size.width * 0.2,
                        // ),
                        // senderMessage(
                        //     context,
                        //     "assets/images/account.png",
                        //     "Hello Doctor?\nHow are you",
                        //     MediaQuery.of(context).size.width * 0.3,
                        //     MediaQuery.of(context).size.height * 0.08),
                        // receiver(
                        //     context,
                        //     "assets/images/account.png",
                        //     "Fine\nI hope you are doing well",
                        //     MediaQuery.of(context).size.height * 0.07,
                        //     MediaQuery.of(context).size.width * 0.5),
                        // receiver(
                        //     context,
                        //     "assets/images/account.png",
                        //     "  Don't forget about your next  \t\t appointment",
                        //     MediaQuery.of(context).size.height * 0.08,
                        //     MediaQuery.of(context).size.width * 0.51),
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * 0.4),
                      ],
                    ),
                  ),
                ),
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
                          height: MediaQuery.of(context).size.width * 0.07,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            controller:
                                userAthenticationController.messageController,
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
                                      .messageController.text.isNotEmpty) {
                                    userAthenticationController.sendMessage(
                                        userAthenticationController
                                            .messageController.text);
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
          )),
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
