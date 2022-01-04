import 'package:cloud_firestore/cloud_firestore.dart';

class NotifitcatioModel {
  String notificationTite;
  String notificaitonBody;
  int responders;
  String date;
  NotifitcatioModel(
      {this.notificaitonBody,
      this.notificationTite,
      this.responders,
      this.date});
  NotifitcatioModel.fromJson(DocumentSnapshot snapShotData) {
    notificaitonBody = snapShotData.data()["notificationBody"];
    notificationTite = snapShotData.data()["notificationtitle"];
    responders = snapShotData.data()["responders"];
    date = snapShotData.data()["date"];
  }
}
