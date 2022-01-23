import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationForApproveModel {
  String notificationtitle;

  String notificationBody;
  String notificatinId;

  Timestamp date;
  String userId;
  String email;
  String unitCode;
  int phoneNumber;
  String role;
  int assignNumber;
  String name;
  String tokanId;
  bool isApproved = false;

  NotificationForApproveModel({
    this.notificatinId,
    this.assignNumber,
    this.date,
    this.email,
    this.name,
    this.notificationBody,
    this.notificationtitle,
    this.phoneNumber,
    this.role,
    this.unitCode,
    this.userId,
    this.isApproved,
  });
  NotificationForApproveModel.fromJson(DocumentSnapshot snapShotData) {
    notificatinId = snapShotData.id;
    notificationtitle = snapShotData.data()["notificationtitle"] ?? "";
    notificationBody = snapShotData.data()["notificationBody"] ?? "";
    date = snapShotData.data()["date"];
    userId = snapShotData.data()["userId"] ?? "";
    email = snapShotData.data()["email"] ?? "";
    unitCode = snapShotData.data()["unitCode"] ?? "";
    phoneNumber = snapShotData.data()["phoneNumber"] ?? 0;
    role = snapShotData.data()["role"] ?? "";
    assignNumber = snapShotData.data()["assignNumber"] ?? 0;
    name = snapShotData.data()["name"] ?? "";
    tokanId = snapShotData.data()["tokanId"] ?? "";
    isApproved = snapShotData.data()["isaAccountapprove"] ?? false;
    print("Is approved is $isApproved");
    print(name);
  }
}
