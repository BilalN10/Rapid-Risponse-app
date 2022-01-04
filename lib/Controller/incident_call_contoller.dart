import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/notification_model.dart';

class IncidentCallController extends GetxController {
  UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();

  Rx<List<NotifitcatioModel>> notificationList =
      Rx<List<NotifitcatioModel>>([]);
  List<NotifitcatioModel> get getNotificationList => notificationList.value;
  @override
  void onInit() {
    super.onInit();
    notificationList.bindStream(notificationStream());
  }

  Stream<List<NotifitcatioModel>> notificationStream() {
    print("enter in add function");
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userAthenticationController.users.uid)
        .collection("Notifications")
        //.orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<NotifitcatioModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(NotifitcatioModel.fromJson(element));
      });

      print(' Notificaiton  lenght is ${retVal.length}');
      return retVal;
    });
  }
}
