import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/role_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Authentication/sign_screen.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

class DefineRoleScreen extends StatefulWidget {
  DefineRoleScreen({Key key}) : super(key: key);

  @override
  State<DefineRoleScreen> createState() => _DefineRoleScreenState();
}

class _DefineRoleScreenState extends State<DefineRoleScreen> {
  @override
  void initState() {
    if (userAthenticationController.users != null) {
      userAthenticationController.checkUserAccountSatus();
    }
    super.initState();
  }

  final UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFf3f4fd),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColors.primary,
        centerTitle: true,
        title: const Text("Define Your Role"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 10 * SizeConfig.heightMultiplier,
            // ),

            Container(
              //margin: EdgeInsets.all(0),
              height: 80 * SizeConfig.heightMultiplier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10,
                      //mainAxisExtent:
                    ),
                    itemCount: roleModelList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            print(
                                "Assign Number is ${roleModelList[index].assignNumber}");
                            userAthenticationController.assignNumber =
                                roleModelList[index].assignNumber;
                            userAthenticationController.defineRole =
                                roleModelList[index].name;
                            userAthenticationController.roleImage =
                                roleModelList[index].imgPath;

                            Get.to(() => SigninScreen());
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 20 * SizeConfig.heightMultiplier,
                              width: 45 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black12,
                                      //offset: Offset(2, 2)
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 20 * SizeConfig.imageSizeMultiplier,
                                    color: MyColors.primary,
                                  ),
                                  Text(
                                    roleModelList[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                  // Icon(
                                  //   Icons.team,
                                  //   size: 20 * SizeConfig.imageSizeMultiplier,
                                  //   color: MyColors.primary,
                                  // )

                                  // Icon(icon)
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Center(
            //   child: Container(
            //     height: 20 * SizeConfig.heightMultiplier,
            //     width: 47 * SizeConfig.widthMultiplier,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.white,
            //         boxShadow: const [
            //           BoxShadow(
            //               blurRadius: 20,
            //               color: Colors.black12,
            //               offset: Offset(2, 2))
            //         ]),
            //     child: Column(
            //       children: [
            //         // Icon(
            //         //   Icons.team,
            //         //   size: 20 * SizeConfig.imageSizeMultiplier,
            //         //   color: MyColors.primary,
            //         // )

            //         // Icon(icon)
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
