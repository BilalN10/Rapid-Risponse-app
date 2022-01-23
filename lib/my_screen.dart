import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_context/one_context.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(blurRadius: 20, color: Colors.black12),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: const Text(
                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,")),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: const Text(
                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,",
                                  maxLines: 2,
                                ),
                              ),
                              Switch(
                                activeColor: Colors.amber,
                                value: isChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    isChecked = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Heading text",
                        style: TextStyle(
                            color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 320,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        children: [
                          myWidget(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia",
                            Switch(
                              activeColor: Colors.amber,
                              value: isTwoChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  isTwoChecked = value;
                                });
                              },
                            ),
                          ),
                          const Divider(),
                          myWidget(
                            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia",
                            Switch(
                              activeColor: Colors.amber,
                              value: isThreeChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  isThreeChecked = value;
                                });
                              },
                            ),
                          ),
                          const Divider(),
                          myWidget(
                            "Lorem ipsum dolor sit ",
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 18,
                                    )
                                  ]),
                              child: myDropdown(),
                            ),
                          ),
                          const Divider(),
                          myWidget(
                            "Lorem ipsum dolor sit ",
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 18,
                                    )
                                  ]),
                              child: myDropdown(),
                            ),
                          ),
                          const Divider(),
                          myWidget(
                            "Lorem ipsum dolor sit ",
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 18,
                                    )
                                  ]),
                              child: myDropdown(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _showMyDialog();
                    },
                    child: Text("Show PoP up"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myWidget(String text, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Text(
            text,
            maxLines: 2,
          ),
        ),
        widget
      ],
    );
  }

  Widget myDropdown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
        color: Colors.amber,
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: const SizedBox(),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,

          //title: const Text('AlertDialog Title'),
          content: Container(
            width: 350,
            height: 250,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/mosque.jpg",
                    ),
                    fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.amber,

                          // borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(
                          "Title",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 205,
                        width: 250,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Middle Text of Dailog Box"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 33,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Cencel",
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 33,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Text(
                                      "Confirm",
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[

          //     ],
          //   ),
          // ),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Approve'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
