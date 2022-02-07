import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatReferanceModel {
  RxString eventTitle = "".obs;
  DocumentReference documentReference;
  ChatReferanceModel({this.documentReference, this.eventTitle});

  ChatReferanceModel.fromJason(DocumentSnapshot data) {
    documentReference = data.data()["ChatReferance"] ?? "";
    print("My title is $eventTitle");

    documentReference.get().then((data) {
      if (data.exists) {
        eventTitle.value = data.data()["eventTitle"] ?? "";
      } else {
        eventTitle.value = "no data";
      }
      print("event title is ");
      // print("event titile is ${chatController.eventTitle.value}");
    });
  }
}
