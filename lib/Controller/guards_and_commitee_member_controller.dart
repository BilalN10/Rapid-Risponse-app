import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/generated_property_model.dart';
import 'package:rapid_response/Model/user_model.dart';
import 'package:rapid_response/Model/userinfo_referance_model.dart';
import 'package:rapid_response/Views/UserProfile/user_profile.dart';

class GuardsandMemberController extends GetxController {
  UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());
  @override
  void onInit() {
    generatedPropertyList.bindStream(generatedPropertyStream());
  }

  RxString adminPropertyCode = ''.obs;

  // UserAthenticationController userAthenticationController =
  //     Get.find<UserAthenticationController>();
  Rx<List<UserInfoReferanceModel>> userInfoList =
      Rx<List<UserInfoReferanceModel>>([]);
  List<UserInfoReferanceModel> get getuserInfoList => userInfoList.value;

  Rx<List<GeneratedPropertyModel>> generatedPropertyList =
      Rx<List<GeneratedPropertyModel>>([]);
  List<GeneratedPropertyModel> get getGeneratedPropertyList =>
      generatedPropertyList.value;

  List<String> propertyList = [];

  Stream<List<GeneratedPropertyModel>> generatedPropertyStream() {
    print("enter in add function");
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userAthenticationController.users.uid)
        .collection("GeneratedProperty")

        //.orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<GeneratedPropertyModel> retVal = List();
      for (var element in query.docs) {
        propertyList.add(element.id);
        adminPropertyCode.value = propertyList[0];

        retVal.add(GeneratedPropertyModel.fromSnamshot(element));
      }
      // print("property length is ${propertyList[1]}");

      print('Property lenght is ${retVal.length}');
      return retVal;
    });
  }

  void getuserInfo(String infoId) {
    userInfoList.bindStream(userINfoStream(infoId));
  }

  Stream<List<UserInfoReferanceModel>> userINfoStream(String infoId) {
    print("en add function");
    print(infoId);
    print(userAthenticationController.users.uid);
    return userAthenticationController.firebaseFirestore
        .collection('Users')
        .doc(userAthenticationController.users.uid)
        .collection("GeneratedProperty")
        .doc(infoId)
        .collection("UserInfo")
        .snapshots()
        .map((QuerySnapshot query) {
      print(query.docs.length);
      List<UserInfoReferanceModel> retVal = List();
      for (var element in query.docs) {
        retVal.add(UserInfoReferanceModel.fromSnapShor(element));
      }

      print('all user length is  lenght is ${retVal.length}');
      return retVal;
    });
  }

  void changeRole(String id, int assigValue, String userIdInfo) {
    String role;
    if (assigValue == 222) {
      role = "Guard";
    } else if (assigValue == 333) {
      role = "Commitee member";
    } else if (assigValue == 444) {
      role = "Resident";
    }
    userAthenticationController.firebaseFirestore
        .collection("Users")
        .doc(id)
        .update({
      "role": role,
      "assignNumber": assigValue,
    }).then((value) {
      getuserInfo(userIdInfo);
      //debugPrint("Updated");

      //Get.snackbar("Role Updated", "Role changed successfully");
      OneContext().popDialog();
    }).catchError((e) {
      //  debugPrint("Error $e");
    });
  }
}
