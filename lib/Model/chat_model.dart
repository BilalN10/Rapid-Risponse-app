import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen {
  String txtMessage;
  String id;
  ChatScreen({this.txtMessage});
  ChatScreen.fromJason(DocumentSnapshot snapShotData) {
    id = snapShotData.id;
    txtMessage = snapShotData.data()["txtMessage"];
  }
}
