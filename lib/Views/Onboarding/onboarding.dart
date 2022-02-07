import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';

import 'onboarding_content.dart';

class OnboardPage extends StatefulWidget {
  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "image": "assets/images/mosq_1.png",
      "title": "Meat and poultry is safe. ",
      "subtitle": "It's safer than it's probably ever been",
    },
    {
      "image": "assets/images/mosq_2.png",
      "title": "Meat and poultry is safe. ",
      "subtitle": "It's safer than it's probably ever been",
    },
    {
      "image": "assets/images/mosq_3.png",
      "title": "Meat and poultry is safe. ",
      "subtitle": "It's safer than it's probably ever been",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => OnboardContent(
                  index: index,
                  image: splashData[index]["image"],
                  title: splashData[index]['title'],
                  subtitle: splashData[index]['subtitle'],
                ),
              ),
              Positioned(
                bottom: 2,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5 * SizeConfig.widthMultiplier),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: buildDot(index: index)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    // currentPage == 2
                    //     ? GestureDetector(
                    //         onTap: () {
                    //           // Get.to(() => SignInScreen());
                    //         },
                    //         child: Container(
                    //           alignment: Alignment.center,
                    //           height: 6 * SizeConfig.heightMultiplier,
                    //           width: 80 * SizeConfig.widthMultiplier,
                    //           decoration: BoxDecoration(
                    //             color: Colors.blue,
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //           child: Text(
                    //             "LET'S' GO",
                    //           ),
                    //         ),
                    //       )
                    Container(
                      width: 90 * SizeConfig.widthMultiplier,
                      // margin: const EdgeInsets.only(bottom: 0),
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                                onPressed: () {
                                  //  Get.to(() => SignInScreen());
                                },
                                child: Row(
                                  children: [
                                  const  Text(
                                      "Skip",
                                      style: TextStyle(color: Colors.white),
                                      //   style: MyTextStyles.bodyText2
                                      //       .copyWith(color: primaryClr),
                                      // ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                        size:
                                            4 * SizeConfig.imageSizeMultiplier,
                                      ),
                                    )
                                  ],
                                ))
                          ]),
                    ),
                    // currentPage == 2
                    //     ? SizedBox(
                    //         height: 5.5 * SizeConfig.heightMultiplier,
                    //       )
                    SizedBox(
                      height: 4.5 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 2.5 * SizeConfig.heightMultiplier,
      width: 2.5 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.amber : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.amber,
          )),
    );
  }
}
