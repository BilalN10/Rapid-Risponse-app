import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({Key key}) : super(key: key);

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  int myindex = 0;
  TimeOfDay selectedTime = TimeOfDay.now();
  ItemScrollController _mintScrollController = ItemScrollController();
  ItemScrollController _seconScrollController = ItemScrollController();
  ItemScrollController _hoursScrollController = ItemScrollController();

  List<String> hoursList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07'
        '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
  ];
  List<String> minutesList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    "07"
        '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
  ];
  List<String> secondsList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    "07",
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 180,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                const Text("Lorem ipsum dolor sit amet consectetur"),
                const SizedBox(
                  height: 20,
                ),
                buttonWidget(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 0.6 * MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 15, color: Colors.black12)
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Time",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      prayerTimeWidget("Name", "4:00 pm"),
                      const Divider(),
                      prayerTimeWidget("Name", "4:00 pm"),
                      const Divider(),
                      prayerTimeWidget("Name", "4:00 pm"),
                      const Divider(),
                      prayerTimeWidget("Name", "4:00 pm"),
                      const Divider(),
                      prayerTimeWidget("Name", "4:00 pm"),
                      const Divider(),
                      prayerTimeWidget("Name", "4:00 pm"),
                      const Divider(),
                      prayerTimeWidget("Name", "4:00 pm"),
                      const Divider(),
                      RaisedButton(
                        onPressed: () {
                          _showMyDialog(context);
                        },
                        child: Text("Show PoP up"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
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
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //       "assets/images/mosque.jpg",
                  //     ),
                  //     fit: BoxFit.cover)),
                  ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_off_sharp,
                              color: Colors.white,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Prayer Name")],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _hoursScrollController.scrollTo(
                                  index: 0,
                                  duration: Duration(milliseconds: 100));
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: Colors.amber,
                              size: 30,
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: ScrollablePositionedList.builder(
                              itemScrollController: _hoursScrollController,
                              itemCount: hoursList.length,
                              itemBuilder: (context, index) {
                                // myindex = index;

                                return Text(
                                  hoursList[index],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _hoursScrollController.scrollTo(
                                  index: hoursList.length,
                                  duration: Duration(milliseconds: 100));
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.amber,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _mintScrollController.scrollTo(
                                  index: 0,
                                  duration: Duration(milliseconds: 100));
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: ScrollablePositionedList.builder(
                              itemScrollController: _mintScrollController,
                              itemCount: minutesList.length,
                              itemBuilder: (context, index) {
                                // myindex = index;

                                return Text(
                                  minutesList[index],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _mintScrollController.scrollTo(
                                  index: minutesList.length,
                                  duration: Duration(milliseconds: 100));
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _seconScrollController.scrollTo(
                                  index: 0,
                                  duration: Duration(milliseconds: 100));
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            child: ScrollablePositionedList.builder(
                              itemScrollController: _seconScrollController,
                              itemCount: secondsList.length,
                              itemBuilder: (context, index) {
                                myindex = index;
                                print("index is $index");

                                print("myindex is $myindex");

                                return Text(
                                  secondsList[index],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _seconScrollController.scrollTo(
                                  index: secondsList.length,
                                  duration: Duration(milliseconds: 100));
                            },
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 30,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: const Text('AM'),
                              //color: Colors.amber,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: const Text('PM'),
                              //color: Colors.red,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),

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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
  }

  Widget prayerTimeWidget(String prayerName, String prayerTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prayerName,
          ),
          Text(
            prayerTime,
          ),
          Row(
            children: [
              Icon(
                Icons.edit_off_rounded,
                size: 20,
              ),
              Icon(
                Icons.notifications_active,
                size: 20,
              ),
              Icon(
                Icons.volume_down_outlined,
                size: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Lorem ipsum dolor sit",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lorem ",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.location_on,
                color: Colors.white,
              )
            ],
          ),
        ),
      ],
    );
  }
}
