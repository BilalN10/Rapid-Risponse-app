import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/notification_for_approve_model.dart';
import 'package:rapid_response/Views/Constants/colors.dart';

class NotificationForApprovrAccount extends GetxController {
  @override
  void onInit() {
    notificationForApproveList
        .bindStream(getApproveAccountNotificationStream());

    super.onInit();
  }

  RxBool isAproved = false.obs;

  UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());
  Rx<List<NotificationForApproveModel>> notificationForApproveList =
      Rx<List<NotificationForApproveModel>>([]);
  List<NotificationForApproveModel> get getnotificationForApproveList =>
      notificationForApproveList.value;

  Stream<List<NotificationForApproveModel>>
      getApproveAccountNotificationStream() {
    return userAthenticationController.firebaseFirestore
        .collection('Users')
        .doc(userAthenticationController.users.uid)
        .collection("NotificationforApprove")
        .snapshots()
        .map((QuerySnapshot query) {
      List<NotificationForApproveModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(NotificationForApproveModel.fromJson(element));
      });

      print('Apprrove Notificaiton Length is ${retVal.length}');
      return retVal;
    });
  }

  void approveAccount(String userId, String tokinId) {
    userAthenticationController.firebaseFirestore
        .collection("Users")
        .doc(userId)
        .update({"isaAccountapprove": true}).then((value) {
      print("Account approved");
      Get.snackbar("Approved", "Account approved  succesfully",
          colorText: MyColors.black);
      OneSignal.shared.postNotification(OSCreateNotification(
        // additionalData: {
        //   'data': 'this is our data',
        //   "eventCreatorId": users.uid,
        //   "broadCastChatID": broadCastCChatId
        // },
        heading: "Account approved",
        // subtitle: dialogNotifiactionTitelController.text,
        playerIds: [tokinId],
        content: "Congratulation Your account is approved",
      ));
    });
  }

  void isAccountApproved(String id) {
    userAthenticationController.firebaseFirestore
        .collection("Users")
        .doc(id)
        .get()
        .then((value) {
      NotificationForApproveModel.fromJson(value);
    });
  }
}
