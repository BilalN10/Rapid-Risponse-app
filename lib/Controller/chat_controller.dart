import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/available_person_model.dart';
import 'package:rapid_response/Model/chat_model.dart';
import 'package:rapid_response/Model/chat_referance_model.dart';
import 'package:rapid_response/Model/user_model.dart';

class ChatController extends GetxController {
  UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();
  Rx<List<ChatModel>> chatList = Rx<List<ChatModel>>([]);
  List<ChatModel> get getchatList => chatList.value;
  RxString eventTitle = "".obs;

  RxBool isAvailable = false.obs;
  RxBool isAvailableClosed = false.obs;

  Rx<List<AvailableRespoderModel>> availableRespoderList =
      Rx<List<AvailableRespoderModel>>([]);
  List<AvailableRespoderModel> get grtAvailableRespoderList =>
      availableRespoderList.value;
  Rx<List<ChatReferanceModel>> chatReferance = Rx<List<ChatReferanceModel>>([]);
  List<ChatReferanceModel> get getChatReferance => chatReferance.value;

  Rx<List<ChatModel>> closedEventConversation = Rx<List<ChatModel>>([]);
  List<ChatModel> get getClosedEventConversation =>
      closedEventConversation.value;
  Rx<List<AvailableRespoderModel>> closedEventResponder =
      Rx<List<AvailableRespoderModel>>([]);
  List<AvailableRespoderModel> get getClosedEventclosedEventResponder =>
      closedEventResponder.value;

  Rx<List<UserModel>> adminList = Rx<List<UserModel>>([]);
  List<UserModel> get grtadminList => adminList.value;

  @override
  void onInit() {
    chatList.bindStream(getChatStream());
    availableRespoderList.bindStream(getAvailableRsponder());
    adminList
        .bindStream(getAdminStream(userAthenticationController.user.adminId));

    chatReferance.bindStream(getChatReferanceStream());

    super.onInit();
  }

  void callClosedEventConversation(DocumentReference documentReference) {
    closedEventConversation
        .bindStream(getClosedEventConversationStream(documentReference));
    closedEventResponder
        .bindStream(getAvailableResponderinClosedEvent(documentReference));
  }

  Stream<List<ChatModel>> getClosedEventConversationStream(
      DocumentReference documentReference) {
    return documentReference
        .collection("Conversation")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatModel> retVal = List();

      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        retVal.add(ChatModel.fromJason(element));
      });

      debugPrint('closed event length is  is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<AvailableRespoderModel>> getAvailableResponderinClosedEvent(
      DocumentReference documentReference) {
    return documentReference
        .collection("AvailablRespoder")
        .snapshots()
        .map((QuerySnapshot query) {
      List<AvailableRespoderModel> retVal = List();

      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        retVal.add(AvailableRespoderModel.fromJason(element));
      });

      debugPrint('closed event Responsder length is  is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<ChatReferanceModel>> getChatReferanceStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userAthenticationController.users.uid)
        .collection("BroadcastChatEvent")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatReferanceModel> retVal = List();
      DocumentReference documentReference;

      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        retVal.add(ChatReferanceModel.fromJason(element));
      });

      debugPrint('chat length is  is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<ChatModel>> getChatStream() {
    debugPrint("enter in add function");
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userAthenticationController.eventCreatorId)
        .collection("BroadcastChat")
        .doc(userAthenticationController.chatID)
        .collection("Conversation")
        //.where("assignNumber", isGreaterThan: 222)
        .orderBy('date', descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(ChatModel.fromJason(element));
      }

      debugPrint('chat length is  is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<AvailableRespoderModel>> getAvailableRsponder() {
    debugPrint("enter in add function");
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userAthenticationController.eventCreatorId)
        .collection("BroadcastChat")
        .doc(userAthenticationController.chatID)
        .collection("AvailablRespoder")
        //.where("assignNumber", isGreaterThan: 222)
        //.orderBy('date', descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<AvailableRespoderModel> retVal = List();
      for (var element in query.docs) {
        retVal.add(AvailableRespoderModel.fromJason(element));
      }

      debugPrint('Available repsonder list length   is ${retVal.length}');
      return retVal;
    });
  }

  void closeEvent() {
    userAthenticationController.firebaseFirestore
        .collection("Users")
        .doc(userAthenticationController.eventCreatorId)
        .collection("BroadcastChat")
        .doc(userAthenticationController.chatID)
        .update({"isEventClose": true}).then((value) {
      DocumentReference cahtRef = userAthenticationController.firebaseFirestore
          .collection('Users')
          .doc(userAthenticationController.users.uid)
          .collection("BroadcastChat")
          .doc(userAthenticationController.broadCastCChatId);
      userAthenticationController.firebaseFirestore
          .collection("Users")
          .doc(userAthenticationController.user.adminId)
          .collection("BroadcastChatEvent")
          .add({"ChatReferance": cahtRef}).then((value) {
        debugPrint("Referance add");
      });

      debugPrint("Event Closed");
      userAthenticationController.checkIsEventClosed();
    });
  }

  Stream<List<UserModel>> getAdminStream(String adminId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .where("adminId", isEqualTo: adminId)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      for (var element in query.docs) {
        retVal.add(UserModel.fromSnamshot(element));
      }

      debugPrint('admin list is ${retVal.length}');
      return retVal;
    });
  }
}
