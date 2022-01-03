import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/user_model.dart';

class GuardsandMemberController extends GetxController {
  @override
  void onInit() {
    herlpersList.bindStream(confirmClientStream());
  }

  // UserAthenticationController userAthenticationController =
  //     Get.find<UserAthenticationController>();
  Rx<List<UserModel>> herlpersList = Rx<List<UserModel>>([]);
  List<UserModel> get herlperList => herlpersList.value;

  Stream<List<UserModel>> confirmClientStream() {
    print("enter in add function");
    return FirebaseFirestore.instance
        .collection('Users')
        .where("assignNumber", isGreaterThan: 222)
        //.orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserModel.fromSnamshot(element));
      });

      print('lenght is ${retVal.length}');
      return retVal;
    });
  }
}
