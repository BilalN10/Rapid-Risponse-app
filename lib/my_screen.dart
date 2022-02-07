import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key key}) : super(key: key);

  @override
  _MYScreenState createState() => _MYScreenState();
}

class _MYScreenState extends State<MyScreen> {
  bool isChecked = false;
  bool isTwoChecked = false;
  bool isThreeChecked = false;
  String dropdownValue = 'One';
  String dropOnedownValue = 'One';
  String dropTwodownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 180,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  myTitle(),
                  SizedBox(
                    height: 20,
                  ),
                  myTitle(),
                  SizedBox(
                    height: 20,
                  ),
                  myTitle(),
                  SizedBox(
                    height: 20,
                  ),
                  myTitle()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myTitle() {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Colors.black12),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Title",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Descriptio",
                  style: TextStyle(color: Colors.amber),
                ),
              ],
            ),
            Row(
              children: const [
                Icon(
                  Icons.book,
                  color: Colors.amber,
                ),
                Text(
                  "Title",
                  style: TextStyle(),
                ),
              ],
            ),
            Row(
              children: const [
                Icon(
                  Icons.volume_up,
                  color: Colors.amber,
                ),
                Text(
                  "Title",
                  style: TextStyle(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //
}
