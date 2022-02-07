import 'package:flutter/material.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/google_maps.dart';

class GooleMapsScreen extends StatefulWidget {
  const GooleMapsScreen({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GooleMapsScreen> {
  List<Widget> tabBar = [
    const GoogleMaps(),
    Container(
      child: Text("2"),
    ),
    Container(
      child: Text("3"),
    ),
    Container(
      child: Text("4"),
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: BackButton(color: JssColors.judul),
        leading: Container(
          margin: const EdgeInsets.only(left: 16.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: IconButton(
            icon: Image.asset('assets/images/home.png'),
            onPressed: () {
              //OneContext().pushNamed(LoginScreen.tag);
            },
          ),
        ),
        title: const Text(
          "Rapid Response",
          style:
              TextStyle(color: MyColors.secondary, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // _drawerKey.currentState?.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  color: MyColors.grey_3,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 8),
              child: Container(
                height: 57,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.black26)
                  ],
                  // border: Border.all(width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navItem(
                      "Plot",
                      0,
                    ),
                    navItem("Navigate", 1),
                    navItem("Markers", 2),
                    navItem("Search", 3)
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: tabBar[selectedIndex])
        ],
      ),
    );
  }

  Widget navItem(String name, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 1.5 * SizeConfig.heightMultiplier,
                    color: selectedIndex == index ? Colors.red : Colors.grey),
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier,
              ),
              Container(
                width: 50,
                height: 3,
                color: selectedIndex == index ? Colors.red : Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
