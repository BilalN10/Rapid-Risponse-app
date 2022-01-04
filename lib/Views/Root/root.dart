import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Views/Authentication/role_define_screen.dart';
import 'package:rapid_response/Views/Authentication/sign_screen.dart';
import 'package:rapid_response/Views/Rapid_Response/rapid_response.dart';

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<UserAthenticationController>(
      initState: (_) {
        Get.put<UserAthenticationController>(UserAthenticationController());
      },
      builder: (_) {
        if (Get.find<UserAthenticationController>().users != null) {
          return RapidResponseScreen(
            isRespospoding: false,
          );
        } else {
          return DefineRoleScreen();
        }
      },
    );
  }
}
