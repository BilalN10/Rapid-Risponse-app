import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/available_person_model.dart';
import 'package:rapid_response/Model/chat_model.dart';

class ChatController extends GetxController {
  UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();
  Rx<List<ChatModel>> chatList = Rx<List<ChatModel>>([]);
  List<ChatModel> get getchatList => chatList.value;

  RxBool isAvailable = false.obs;

  Rx<List<AvailableRespoderModel>> availableRespoderList =
      Rx<List<AvailableRespoderModel>>([]);
  List<AvailableRespoderModel> get grtAvailableRespoderList =>
      availableRespoderList.value;

  @override
  void onInit() {
    chatList.bindStream(getCahtScreen());
    availableRespoderList.bindStream(getAvailableRsponder());

    super.onInit();
  }

  Stream<List<ChatModel>> getCahtScreen() {
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
}
