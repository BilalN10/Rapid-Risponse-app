import 'package:cloud_firestore/cloud_firestore.dart';
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
    adminList.bindStream(getAdminStream());

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

      query.docs.forEach((element) {
        retVal.add(ChatModel.fromJason(element));
      });

      print('closed event length is  is ${retVal.length}');
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

      query.docs.forEach((element) {
        retVal.add(AvailableRespoderModel.fromJason(element));
      });

      print('closed event Responsder length is  is ${retVal.length}');
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

      query.docs.forEach((element) {
        retVal.add(ChatReferanceModel.fromJason(element));
      });

      print('chat length is  is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<ChatModel>> getChatStream() {
    print("enter in add function");
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
      List<ChatModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(ChatModel.fromJason(element));
      });

      print('chat length is  is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<AvailableRespoderModel>> getAvailableRsponder() {
    print("enter in add function");
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
      query.docs.forEach((element) {
        retVal.add(AvailableRespoderModel.fromJason(element));
      });

      print('Available repsonder list length   is ${retVal.length}');
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

      for (int i = 0; i < grtadminList.length; i++) {
        print("admin id is ${grtadminList[i].id}");
        userAthenticationController.firebaseFirestore
            .collection("Users")
            .doc(grtadminList[i].id)
            .collection("BroadcastChatEvent")
            .add({"ChatReferance": cahtRef}).then((value) {
          print("Referance add");
        });
      }
      print("Event Closed");
      userAthenticationController.checkIsEventClosed();
    });
  }

  Stream<List<UserModel>> getAdminStream() {
    return FirebaseFirestore.instance
        .collection('Users')
        .where("assignNumber", isEqualTo: 111)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserModel.fromSnamshot(element));
      });

      print('admin list is ${retVal.length}');
      return retVal;
    });
  }
}
