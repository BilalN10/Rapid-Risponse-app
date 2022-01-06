import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String txtMessage;
  String id;
  String senderId;
  String name;
  String satus;
  ChatModel({this.txtMessage, this.senderId});
  ChatModel.fromJason(DocumentSnapshot snapShotData) {
    name = snapShotData.data()["senderName"] ?? "";
    id = snapShotData.id;
    txtMessage = snapShotData.data()["txtMessage"] ?? "";
    senderId = snapShotData.data()["messageSenderID"] ?? "";
    satus = snapShotData.data()["satus"] ?? "";
  }
}
