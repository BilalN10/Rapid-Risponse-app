import 'package:flutter/material.dart';
import 'package:rapid_response/tab1_data.dart';
import 'package:rapid_response/tab2_data.dart';

class MyClass extends StatefulWidget {
  const MyClass({Key key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyClass> {
  List<Widget> pages = [
    Tab1Data(),
    Tab2Data(),
    Tab1Data(),
    //tab1_data()
    // UpcomingBar(),
    // RecentBar(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      height: 180,
                      width: 340,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/mosq_3.png')),
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 10, color: Colors.black12),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      height: 30,
                                      width: 20,
                                      child: Image.asset(
                                        "assets/images/moon.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Text"),
                                        Text(
                                          "Emirates",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                            // fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text("My Text"),
                        ],
                      ),
                    );
                  }),
            ),
            tabBar(),
            SizedBox(height: 450, child: pages[selectedIndex]),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Container(
            //     height: 50,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //         color: Colors.grey[300],
            //         borderRadius: BorderRadius.circular(20)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 1 * SizeConfig.widthMultiplier),
      height: 40,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.shade300,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          tabBarTile('Current', 0),
          tabBarTile('Recent', 1),
          tabBarTile('Tab 3', 2)
        ],
      ),
    );
  }

  Widget tabBarTile(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
