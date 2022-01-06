import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableRespoderModel {
  String id;
  String role;
  String responderName;
  String status;
  AvailableRespoderModel({this.id, this.responderName, this.role, this.status});
  AvailableRespoderModel.fromJason(DocumentSnapshot snapShotData) {
    responderName = snapShotData.data()["responderName"] ?? "";
    id = snapShotData.id;
    role = snapShotData.data()["role"] ?? "";
    status = snapShotData.data()["status"] ?? "";
  }
}
