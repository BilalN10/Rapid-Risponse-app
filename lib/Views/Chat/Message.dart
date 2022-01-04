import 'package:flutter/material.dart';

import 'doccotor_message.dart';

class Meassge extends StatefulWidget {
  const Meassge({Key key}) : super(key: key);

  @override
  _MeassgeState createState() => _MeassgeState();
}

class _MeassgeState extends State<Meassge> {
  final _color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search messages",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(100),
                    )),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorMessage()));
              },
              child: messageList(context, "assets/images/doc4.png",
                  "Tawfiq Bahri", "Your Next appointment", "11:05 AM",
                  messages: 10)),
          messageList(
            context,
            "assets/images/doc3.png",
            "Jouseph Bouroumat",
            "Don't forgot your blood test",
            "08:31 AM",
            messages: 2,
          ),
          messageList(context, "assets/images/fm.jpg", "Liza Anderson",
              "You: Good news", "03:40 PM"),
          Container(
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Container messageList(BuildContext context, String path, String doctorName,
      String message, String time,
      {int messages}) {
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
                      color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                    // width: 20,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: messages != null ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: messages != null
                            ? Text(messages.toString())
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
                    color: Colors.blue,
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
