import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_context/one_context.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rapid_response/Model/user_model.dart';
import 'package:rapid_response/Views/Authentication/role_define_screen.dart';
import 'package:rapid_response/Views/Chat/message_screen.dart';
import 'package:rapid_response/Views/Constants/mydialog.dart';
import 'package:rapid_response/Views/Incident_calls/incident_calls_screen.dart';
import 'package:rapid_response/Views/Rapid_Response/rapid_response.dart';
import 'package:intl/intl.dart';

class UserAthenticationController extends GetxController {
  @override
  void onInit() {
    getUser();
    //sendAlertto(333);
    firebaseUser.bindStream(auth.authStateChanges());
    adminList.bindStream(getAdminStream());
    //googleSignInAccounts.bindStream(googleSignIn..s);
    print("user is $googleSignInAccount");
    RxInt frequencyValue = 0.obs;
    //googleSignInAccount.
    super.onInit();
  }

  //TextEditingController for SignUp
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupUserNameController = TextEditingController();
  TextEditingController signupUnitCodeController = TextEditingController();
  TextEditingController signupPhoneNumberController = TextEditingController();
  TextEditingController signupPropertyCodeController = TextEditingController();

  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController editname = TextEditingController();
  TextEditingController dialogNotifiactionController = TextEditingController();
  TextEditingController dialogNotifiactionTitelController =
      TextEditingController();

  //Sign in Controller
  TextEditingController signinEmailController = TextEditingController();
  TextEditingController signinPasswordController = TextEditingController();
  TextEditingController signinPropertyCodeController = TextEditingController();

//Reset email Textfield
  TextEditingController resetEmailController = TextEditingController();

//edit profile Controller
  TextEditingController editmail = TextEditingController();
  TextEditingController editPhonenumber = TextEditingController();
  //Message controller
  TextEditingController messageController = TextEditingController();

  //Create property Controller
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController propertyCodeController = TextEditingController();

  // Firebase
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Rxn<User> firebaseUser = Rxn<User>();
  User get users => firebaseUser.value;

// assigning role  and definig role variable
  int assignNumber = 0;
  String defineRole = "";
  String roleImage;
  //Controller loading variabae
  RxBool isSignUpLoading = false.obs;
  RxBool isSignInLoading = false.obs;
  RxBool isProfileChange = false.obs;
  String broadCastCChatId;

  File image;
  String eventCreatorId;
  String chatID;

  RxBool isEventClose = false.obs;
  RxString eventCreaterUid = "".obs;

  RxBool isResponding = false.obs;
  RxBool isAvalailable = false.obs;

  Rx<List<UserModel>> adminList = Rx<List<UserModel>>([]);
  List<UserModel> get getadminListforApprove => adminList.value;

  //Send notificaiton to User list
  Rx<List<String>> sendNotifocationto = Rx<List<String>>([]);
  List<String> get sendNotifoactions => sendNotifocationto.value;
  //Rx<List<String>> getIdfornotificaiton = Rx<List<String>>([]);
  //List<String> get getUserTogetNotification => getIdfornotificaiton.value;

  Rxn<GoogleSignInAccount> googleSignInAccounts = Rxn<GoogleSignInAccount>();
  GoogleSignInAccount get googleSignInAccount => googleSignInAccounts.value;
  set googleSignInAccount(GoogleSignInAccount name) {
    googleSignInAccounts.value = name;
  }

  void configOneSignel() {
    print("onedignal congigured");
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("4917de9f-6a26-43c2-92f6-92c83653d49e");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   print("Accepted permission: $accepted");
    // });
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // print("my event data is ${event.notification.additionalData}");
      //eventCreatorId = event.notification.additionalData["eventCreatorId"];
      //chatID = event.notification.additionalData["broadCastChatID"];

      //print("Notificaiton Received");
      if (event.notification.additionalData["isNotificationforPermission"] ==
          true) {
        print(
            "this notification is for approvr ${event.notification.additionalData["tokanId"]}");

        print("user id ${event.notification.additionalData["userId"]}");
        for (int i = 0; i < getadminListforApprove.length; i++) {
          firebaseFirestore
              .collection("Users")
              .doc(getadminListforApprove[i].id)
              .collection("NotificationforApprove")
              .doc(event.notification.additionalData["userId"])
              .set({
            "notificationtitle": event.notification.title,
            "notificationBody": event.notification.body,
            "date": DateTime.now(),
            'userId': event.notification.additionalData["userId"],
            "email": event.notification.additionalData["email"],
            "unitCode": event.notification.additionalData["unitCode"],
            "phoneNumber": event.notification.additionalData["phoneNumber"],
            "role": event.notification.additionalData["role"],
            "assignNumber": event.notification.additionalData["assignNumber"],
            "name": event.notification.additionalData["name"],
            "tokanId": event.notification.additionalData["tokanId"],
            "isaAccountapprove":
                event.notification.additionalData["isaAccountapprove"],
          });
        }
      } else {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

        firebaseFirestore
            .collection("Users")
            .doc(users.uid)
            .collection("Notifications")
            .doc(event.notification.additionalData["broadCastChatID"])
            .set({
          "notificationBody": event.notification.body,
          "notificationtitle": event.notification.title,
          "responders": 0,
          "date": formattedDate,
          "eventCreatorId": event.notification.additionalData["eventCreatorId"],
          "chatID": event.notification.additionalData["broadCastChatID"]
        });
      }
      //Get.to(() => ConfirmClients());
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // eventCreatorId = result.notification.additionalData["eventCreatorId"];
      //chatID = result.notification.additionalData["broadCastChatID"];
      if (result.notification.additionalData["isNotificationforPermission"] ==
          true) {
        print(
            "this notification is for approvr ${result.notification.additionalData}");
        print(
            "this notification is for approvr ${result.notification.additionalData["tokanId"]}");

        print("user id ${result.notification.additionalData["userId"]}");
        for (int i = 0; i < getadminListforApprove.length; i++) {
          firebaseFirestore
              .collection("Users")
              .doc(getadminListforApprove[i].id)
              .collection("NotificationforApprove")
              .doc(result.notification.additionalData["userId"])
              .set({
            "notificationtitle": result.notification.title,
            "notificationBody": result.notification.body,
            "date": DateTime.now(),
            'userId': result.notification.additionalData["userId"],
            "email": result.notification.additionalData["email"],
            "unitCode": result.notification.additionalData["unitCode"],
            "phoneNumber": result.notification.additionalData["phoneNumber"],
            "role": result.notification.additionalData["role"],
            "assignNumber": result.notification.additionalData["assignNumber"],
            "name": result.notification.additionalData["name"],
            "tokanId": result.notification.additionalData["tokanId"],
            "isaAccountapprove":
                result.notification.additionalData["isaAccountapprove"],
            //"date" : DateTime.now(),
          });
        }
      } else {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

        print("i am here");
        firebaseFirestore
            .collection("Users")
            .doc(users.uid)
            .collection("Notifications")
            .doc(result.notification.additionalData["broadCastChatID"])
            .set({
          "notificationBody": result.notification.body,
          "notificationtitle": result.notification.title,
          "responders": 0,
          "date": formattedDate,
          "eventCreatorId":
              result.notification.additionalData["eventCreatorId"],
          "chatID": result.notification.additionalData["broadCastChatID"]
        }).then((value) {
          Get.to(() => IncidentCallsScreen());
        });
      }

      //Get.to(() => ConfirmClients());
      // Will be called whenever a notification is opened/button pressed.
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });
    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });
    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

  RxInt frequencyValue = 0.obs;
  void updateValue(int value) {
    frequencyValue.value = value;
    debugPrint("my value is ${frequencyValue.value}");
    update();
  }

  Rx<UserModel> usermodel = UserModel().obs;
  UserModel get user => usermodel.value;
  set user(UserModel value) => usermodel.value = value;
//get user data

  getUser() async {
    try {
      DocumentSnapshot doc =
          await firebaseFirestore.collection("Users").doc(users.uid).get();
      user = UserModel.fromSnamshot(doc);
      editmail.text = user.email;
      editname.text = user.name;
      editPhonenumber.text = user.phoneNumber;
      debugPrint("my user email is ${user.email} ");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //get
  Stream<List<UserModel>> getAdminStream() {
    return firebaseFirestore
        .collection('Users')
        .where("assignNumber", isEqualTo: 111)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(UserModel.fromSnamshot(element));
      }

      debugPrint('admin list is ${retVal.length}');
      return retVal;
    });
  }

  void resetPassword(String email) {
    auth.sendPasswordResetEmail(email: email.trim()).then((value) {
      MyDialog.sigleButtonDailog(
          middleText:
              "Change Password request is sent on your email address please check your Gamil",
          title: "Email Send",
          buttonText: "Ok",
          function: () {
            OneContext().popDialog();
            debugPrint("ok");
          });

      debugPrint("Email Sent");
    }).catchError((e) {
      debugPrint("Error is $e");
      Get.snackbar("Error", e.toString());
    });
  }

  void checkUserAccountSatus() {
    firebaseFirestore.collection("Users").doc(users.uid).get().then((value) {
      if (value.data()["assignNumber"] != 111) {
        if (value.data()["isaAccountapprove"]) {
          Get.to(() => RapidResponseScreen(
                isRespospoding: false,
              ));
        }
      } else {
        Get.to(() => RapidResponseScreen(
              isRespospoding: false,
            ));
      }
    });
  }

  void checkIsEventClosed() async {
    print("event is $eventCreatorId");
    print("chat is $chatID");
    DocumentSnapshot doc = await firebaseFirestore
        .collection("Users")
        .doc(eventCreatorId)
        .collection("BroadcastChat")
        .doc(chatID)
        .get()
        .then((value) {
      isEventClose.value = value.data()["isEventClose"];
      eventCreaterUid.value = value.data()["uid"];

      print("evevent is ${isEventClose.value}");
    });
  }

// Broadcast Methode
  void sendMessage(String txtMessage, String status) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    checkIsEventClosed();

    firebaseFirestore
        .collection("Users")
        .doc(eventCreatorId)
        .collection("BroadcastChat")
        .doc(chatID)
        .collection("Conversation")
        .add({
      "txtMessage": txtMessage,
      "messageSenderID": users.uid,
      "senderName": user.name,
      "role": user.role,
      "satus": status ?? "",
      "date": DateTime.now()
    }).then((value) {
      messageController.clear();
      print("message sent");
    }).catchError((e) {
      print("message not send error is $e");
    });
  }
  //Create property mthode

  void createProerty() {
    Map<String, dynamic> propertyDetail = {
      "address": addressController.text,
      "city": cityController.text,
      "province": provinceController.text,
      "postalCode": postalCodeController.text,
      "propertyCode": propertyCodeController.text,
      "adminId": users.uid,
      "tokenId": user.tokeID,
      "date": DateTime.now()
    };

    // firebaseFirestore.collection("Properties")
    //     .doc(propertyCodeController.text).get().then((value) => null)
    DocumentReference docRef = firebaseFirestore
        .collection('Properties')
        .doc(propertyCodeController.text);
    docRef.get().then((value) {
      if (value.exists) {
        MyDialog.sigleButtonDailog(
            buttonText: "Ok",
            title: "Property alread Created",
            middleText:
                "Property alredy created in this code Please change the property code",
            function: () {
              OneContext().popDialog();
            });
      } else {
        firebaseFirestore
            .collection("Properties")
            .doc(propertyCodeController.text)
            .set(propertyDetail)
            .then((value) {
          firebaseFirestore
              .collection("Users")
              .doc(users.uid)
              .collection("GeneratedProperty")
              .doc(propertyCodeController.text)
              .set(propertyDetail)
              .then((value) {
            clearController();
            MyDialog.sigleButtonDailog(
                buttonText: "Ok",
                title: "Property Created",
                middleText: "Property created Succefully",
                function: () {
                  OneContext().popDialog();
                });
          }).catchError((e) {
            Get.snackbar("Error", e.toString());
          });
        }).catchError((e) {
          Get.snackbar("Error", e.toString());
        });
      }
    }).catchError((e) {
      Get.snackbar("Error", e.toString());
    });

    //
  }

  //proprty Controller Cleat methode
  void clearController() {
    addressController.clear();
    cityController.clear();
    propertyCodeController.clear();
    postalCodeController.clear();
    provinceController.clear();
  }
  //Available  responder methode

  void availabeResponderMthode(String status) {
    firebaseFirestore
        .collection("Users")
        .doc(eventCreatorId)
        .collection("BroadcastChat")
        .doc(chatID)
        .collection("AvailablRespoder")
        .doc(users.uid)
        .set({
      "responderName": user.name,
      "role": user.role,
      "status": status,
      "dateTime": DateTime.now()
    }).then((value) {
      Get.to(() => DoctorMessage(
            availableStatus: status,
          ));
    });
  }

  //Google sign In Methode
  void googleLogin() async {
    var status = await OneSignal.shared.getDeviceState();
    String tokenID = status.userId;
    String adminId;
    String adminTokenId;

    if (assignNumber != 111) {
      DocumentReference docRef = firebaseFirestore
          .collection('Properties')
          .doc(signinPropertyCodeController.text);

      docRef.get().then((value) async {
        if (value.exists) {
          adminTokenId = value.data()["tokenId"];
          adminId = value.data()["adminId"];

          final GoogleSignInAccount googleUser = await googleSignIn.signIn();
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          print("user credential ${credential.token}");

          final UserCredential authResult =
              await auth.signInWithCredential(credential);
          Map<String, dynamic> userdata = {
            "adminId": adminId,
            "adminTokenId": adminTokenId,
            "name": authResult.user.displayName,
            "email": authResult.user.email,
            "image": authResult.user.photoURL,
            "phoneNumber": authResult.user.phoneNumber ?? 0,
            "role": defineRole,
            "assignNumber": assignNumber,
            "roleImage": roleImage,
            "tokenId": tokenID,
            "isaAccountapprove": assignNumber == 111 ? true : false,
            "unitCode": "",
            "propertyCode": signinPropertyCodeController.text,
            "date": DateTime.now()
          };
          var now = DateTime.now();
          // var _updateTime = DateTime(
          //     now.year, now.month, now.day - 1, now.hour, now.minute, now.second);
          if (authResult.additionalUserInfo.isNewUser) {
            String userIdForNotification;

            FirebaseFirestore.instance
                .collection("Users")
                .doc(authResult.user.uid)
                .set(userdata)
                .then((value) async {
              userIdForNotification = authResult.user.uid;
              if (assignNumber != 111) {
                OneSignal.shared
                    .postNotification(OSCreateNotification(
                  additionalData: {
                    "userId": userIdForNotification,
                    'isNotificationforPermission': true,
                    "name": authResult.user.displayName,
                    "email": authResult.user.email,
                    "unitCode": "",
                    "phoneNumber": authResult.user.phoneNumber,
                    "role": defineRole,
                    "assignNumber": assignNumber,
                    "tokanId": tokenID,
                    "isaAccountapprove": false,
                  },
                  heading: "Request for approve account ",
                  // subtitle: dialogNotifiactionTitelController.text,
                  playerIds: [adminTokenId],
                  content:
                      "${authResult.user.displayName} a $defineRole is waiting for your response",
                ))
                    .then((value) {
                  DocumentReference userDataReference = firebaseFirestore
                      .collection("Users")
                      .doc(userIdForNotification);
                  firebaseFirestore
                      .collection("Users")
                      .doc(adminId)
                      .collection("GeneratedProperty")
                      .doc(signinPropertyCodeController.text)
                      .collection("UserInfo")
                      .doc(userIdForNotification)
                      .set({
                    "userDataReferance": userDataReference,
                  }).then((value) {
                    Get.back();

                    MyDialog.sigleButtonDailog(
                        buttonText: "OK",
                        middleText: "Your account is not approve yet ",
                        title: "Wait for account approve",
                        function: () {
                          OneContext().popDialog();
                          Get.back();
                        });
                  });
                }).catchError((e) {
                  Get.snackbar("Error", e.toString());
                });
              } else {
                Get.to(() => RapidResponseScreen(
                      isRespospoding: false,
                    ));
              }
              //Get.to(SigninScreen());
            });
          } else {
            firebaseFirestore
                .collection("Users")
                .doc(users.uid)
                .get()
                .then((value) {
              if (value.data()["assignNumber"] != assignNumber) {
                print(
                    "assignnumber from firebase is  ${value.data()["assignNumber"]}");
                print("assing number is $assignNumber");
                MyDialog.sigleButtonDailog(
                    buttonText: "OK",
                    middleText:
                        "Your role is not  $defineRole\n Please Select Your Role Correct ",
                    title: "Role Errors",
                    function: () {
                      OneContext().popDialog();
                      Get.back();
                      Get.back();
                    });
              } else if (value.data()["isaAccountapprove"] == false) {
                Get.back();

                MyDialog.sigleButtonDailog(
                    buttonText: "OK",
                    middleText: "Your account is not approve yet",
                    title: "Account not Approve",
                    function: () {
                      OneContext().popDialog();
                    });
              } else if (value.data()["assignNumber"] == 111) {
                Get.offAll(() => RapidResponseScreen(
                      isRespospoding: false,
                    ));
              } else {
                Get.offAll(() => RapidResponseScreen(
                      isRespospoding: false,
                    ));
              }
              isSignInLoading.value = false;

              print(value.data()["name"]);
            }).catchError((e) {
              isSignInLoading.value = false;

              Get.snackbar("Error", e.toString());
            });
            // Get.offAll(RapidResponseScreen(
            //   isRespospoding: false,
            // ));
          }
        } else {
          isSignUpLoading.value = false;
          Get.back();
          MyDialog.sigleButtonDailog(
              buttonText: "OK",
              middleText:
                  "Invalid Property code please enter valid property code",
              title: "Invalid Property code",
              function: () {
                OneContext().popDialog();
              });
        }
      });

//

    } else {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      print("user credential ${credential.token}");

      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      Map<String, dynamic> userdata = {
        "name": authResult.user.displayName,
        "email": authResult.user.email,
        "image": authResult.user.photoURL,
        "phoneNumber": authResult.user.phoneNumber ?? 0,
        "role": defineRole,
        "assignNumber": assignNumber,
        "roleImage": roleImage,
        "tokenId": tokenID,
        "isaAccountapprove": assignNumber == 111 ? true : false,
        "unitCode": "",
        "date": DateTime.now(),
        "adminId": authResult.user.uid,
        "adminTokenId": tokenID,
        "propertyCode": null,
      };
      var now = DateTime.now();
      // var _updateTime = DateTime(
      //     now.year, now.month, now.day - 1, now.hour, now.minute, now.second);
      if (authResult.additionalUserInfo.isNewUser) {
        String userIdForNotification;

        FirebaseFirestore.instance
            .collection("Users")
            .doc(authResult.user.uid)
            .set(userdata)
            .then((value) async {
          userIdForNotification = authResult.user.uid;
          if (assignNumber != 111) {
            OneSignal.shared
                .postNotification(OSCreateNotification(
              additionalData: {
                "userId": userIdForNotification,
                'isNotificationforPermission': true,
                "name": authResult.user.displayName,
                "email": authResult.user.email,
                "unitCode": "",
                "phoneNumber": authResult.user.phoneNumber,
                "role": defineRole,
                "assignNumber": assignNumber,
                "tokanId": tokenID,
                "isaAccountapprove": false,
              },
              heading: "Request for approve account ",
              // subtitle: dialogNotifiactionTitelController.text,
              playerIds: sendNotifoactions,
              content:
                  "${authResult.user.displayName} a $defineRole is waiting for your response",
            ))
                .then((value) {
              MyDialog.sigleButtonDailog(
                  buttonText: "OK",
                  middleText: "Your account is not approve yet ",
                  title: "Wait for account approve",
                  function: () {
                    OneContext().popDialog();
                    Get.back();
                  });
            }).catchError((e) {
              Get.snackbar("Error", e.toString());
            });
          } else {
            Get.to(() => RapidResponseScreen(
                  isRespospoding: false,
                ));
          }
          //Get.to(SigninScreen());
        });
      } else {
        firebaseFirestore
            .collection("Users")
            .doc(users.uid)
            .get()
            .then((value) {
          if (value.data()["assignNumber"] != assignNumber) {
            print(
                "assignnumber from firebase is  ${value.data()["assignNumber"]}");
            print("assing number is $assignNumber");
            MyDialog.sigleButtonDailog(
                buttonText: "OK",
                middleText:
                    "Your role is not  $defineRole\n Please Select Your Role Correct ",
                title: "Role Errors",
                function: () {
                  OneContext().popDialog();
                  Get.back();
                });
          } else if (value.data()["isaAccountapprove"] == false) {
            MyDialog.sigleButtonDailog(
                buttonText: "OK",
                middleText: "Your account is not approve yet",
                title: "Account not Approve",
                function: () {
                  OneContext().popDialog();
                });
          } else if (value.data()["assignNumber"] == 111) {
            Get.offAll(() => RapidResponseScreen(
                  isRespospoding: false,
                ));
          } else {
            Get.offAll(() => RapidResponseScreen(
                  isRespospoding: false,
                ));
          }
          isSignInLoading.value = false;

          print(value.data()["name"]);
        }).catchError((e) {
          isSignInLoading.value = false;

          Get.snackbar("Error", e.toString());
        });
        // Get.offAll(RapidResponseScreen(
        //   isRespospoding: false,
        // ));
      }
    }
  }

  //add notifiaction data to firebase
  void addNotification() {}

  // Send Notification methode
  sendNotification() {
    print("title is ${dialogNotifiactionTitelController.text}");

    firebaseFirestore
        .collection("Users")
        .doc(users.uid)
        .collection("BroadcastChat")
        .add({
      "eventTitle": dialogNotifiactionTitelController.text,
      "isEventClose": false,
      "uid": users.uid
    }).then((value) {
      broadCastCChatId = value.id;
      OneSignal.shared
          .postNotification(OSCreateNotification(
        additionalData: {
          'data': 'this is our data',
          "eventCreatorId": users.uid,
          "broadCastChatID": broadCastCChatId
        },
        heading: dialogNotifiactionTitelController.text,
        // subtitle: dialogNotifiactionTitelController.text,
        playerIds: sendNotifoactions,
        content: dialogNotifiactionController.text,
      ))
          .then((value) {
        firebaseFirestore
            .collection("Users")
            .doc(users.uid)
            .collection("BroadcastChat")
            .doc(broadCastCChatId)
            .collection("Conversation")
            .add({
          "txtMessage": dialogNotifiactionController.text,
          "messageSenderID": users.uid,
          "senderName": user.name,
          "role": user.role,
          "date": DateTime.now()
        });
      }).then((value) {
        dialogNotifiactionController.clear();
        dialogNotifiactionTitelController.clear();
        OneContext().popDialog();
      });
    }).catchError((e) {
      Get.snackbar("Error", e.toString());
    });

    print("back");
    //Get.back();
  }

  void sendAlertDialog(String propertyCode) {
    sendNotifocationto.bindStream(sendAlertto(propertyCode));
    // getIdfornotificaiton.bindStream(getIdtoSendNotificaiton(assignumber));
  }

  Stream<List<String>> sendAlertto(String propertyCode) {
    print("property code is $propertyCode");

    return FirebaseFirestore.instance
        .collection('Users')
        .where("propertyCode", isEqualTo: propertyCode)
        //.orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      print(query.docs.length);
      List<String> retVal = List();
      for (var element in query.docs) {
        print(element.data()["tokenId"]);

        retVal.add(element.data()["tokenId"]);
      }

      print(' my  adm lenght is ${retVal.length}');
      return retVal;
    });

    // if (assignNumber != 0) {
    //    } else {
    //   return FirebaseFirestore.instance
    //       .collection('Users')
    //       //.where("assignNumber", isEqualTo: assignNumber)
    //       //.orderBy('time', descending: true)
    //       .snapshots()
    //       .map((QuerySnapshot query) {
    //     print(query.docs.length);
    //     List<String> retVal = List();
    //     for (var element in query.docs) {
    //       debugPrint(element.data()["tokenId"]);

    //       retVal.add(element.data()["tokenId"]);
    //     }

    //     debugPrint(' my  sdj lenght is ${retVal.length}');
    //     return retVal;
    //   });
    //}
  }

  //final UserCredential authResult =  await auth.signInWithCredential(credential);

  void signUP({
    String email,
    String password,
    String userName,
    String unitCode,
    int phoneNumber,
    String confirmPassword,
    String propertyCode,
  }) async {
    try {
      String userIdForNotification;
      var status = await OneSignal.shared.getDeviceState();
      String tokenID = status.userId;
      String adminId;
      String adminTokenId;

      DocumentReference docRef =
          firebaseFirestore.collection('Properties').doc(propertyCode);
      if (assignNumber != 111) {
        docRef.get().then((value) {
          if (value.exists) {
            adminTokenId = value.data()["tokenId"];
            adminId = value.data()["adminId"];
            print("admin id from snapshot${value.data()["tokenId"]}");

            auth
                .createUserWithEmailAndPassword(
                    email: email.trim(), password: password.trim())
                .then((value) {
              userIdForNotification = value.user.uid;
              firebaseFirestore.collection("Users").doc(value.user.uid).set({
                "adminId": adminId,
                "adminTokenId": adminTokenId,
                "name": userName,
                "email": email,
                "unitCode": unitCode,
                "phoneNumber": phoneNumber,
                "role": defineRole,
                "assignNumber": assignNumber,
                "roleImage": roleImage,
                "tokenId": tokenID,
                "isaAccountapprove": assignNumber == 111 ? true : false,
                "date": DateTime.now(),
                "propertyCode": propertyCode,
                "image":
                    "https://firebasestorage.googleapis.com/v0/b/rapid-response-app-ae749.appspot.com/o/profile-deleted.png?alt=media&token=30a9321f-ff58-4f80-899e-3c6db7896746"
              }).then((value) {
                print("Admin id is $adminId ");
                if (assignNumber != 111) {
                  print("singinUP token id $adminTokenId");
                  OneSignal.shared
                      .postNotification(OSCreateNotification(
                    additionalData: {
                      "userId": userIdForNotification,
                      'isNotificationforPermission': true,
                      "name": userName,
                      "email": email,
                      "unitCode": unitCode,
                      "phoneNumber": phoneNumber,
                      "role": defineRole,
                      "assignNumber": assignNumber,
                      "tokanId": tokenID,
                      "isaAccountapprove": false,
                    },
                    heading: "Request for approve account ",
                    // subtitle: dialogNotifiactionTitelController.text,
                    playerIds: [adminTokenId],
                    content:
                        "$userName a $defineRole is waiting for your response",
                  ))
                      .then((value) {
                    DocumentReference userDataReference = firebaseFirestore
                        .collection("Users")
                        .doc(userIdForNotification);
                    firebaseFirestore
                        .collection("Users")
                        .doc(adminId)
                        .collection("GeneratedProperty")
                        .doc(propertyCode)
                        .collection("UserInfo")
                        .doc(userIdForNotification)
                        .set({
                      "userDataReferance": userDataReference,
                    }).then((value) {
                      MyDialog.sigleButtonDailog(
                          buttonText: "OK",
                          middleText: "Your account is not approve yet ",
                          title: "Wait for account approve",
                          function: () {
                            OneContext().popDialog();
                            Get.back();
                          });
                    });
                  });
                } else {
                  Get.to(() => RapidResponseScreen(
                        isRespospoding: false,
                      ));
                }
              });

              isSignUpLoading.value = false;
              clearSignIpController();
              //Get.to(() => RapidResponseScreen());
            }).catchError((e) {
              Get.snackbar("Error", e.toString());
              isSignUpLoading.value = false;
            });
          } else {
            isSignUpLoading.value = false;
            MyDialog.sigleButtonDailog(
                buttonText: "OK",
                middleText:
                    "Invalid Property code please enter valid property code",
                title: "Invalid Property code",
                function: () {
                  OneContext().popDialog();
                });
          }
        });
      } else {
        auth
            .createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim())
            .then((value) {
          userIdForNotification = value.user.uid;
          firebaseFirestore.collection("Users").doc(value.user.uid).set({
            "adminId": value.user.uid,
            "adminTokenId": tokenID,
            "name": userName,
            "email": email,
            "unitCode": unitCode,
            "phoneNumber": phoneNumber,
            "role": defineRole,
            "assignNumber": assignNumber,
            "roleImage": roleImage,
            "tokenId": tokenID,
            "isaAccountapprove": assignNumber == 111 ? true : false,
            "date": DateTime.now(),
            "propertyCode": null,
            "image":
                "https://firebasestorage.googleapis.com/v0/b/rapid-response-app-ae749.appspot.com/o/profile-deleted.png?alt=media&token=30a9321f-ff58-4f80-899e-3c6db7896746"
          }).then((value) {
            print("Admin id is $adminId ");
            if (assignNumber != 111) {
              print("singinUP token id $adminTokenId");
              OneSignal.shared
                  .postNotification(OSCreateNotification(
                additionalData: {
                  "userId": userIdForNotification,
                  'isNotificationforPermission': true,
                  "name": userName,
                  "email": email,
                  "unitCode": unitCode,
                  "phoneNumber": phoneNumber,
                  "role": defineRole,
                  "assignNumber": assignNumber,
                  "tokanId": tokenID,
                  "isaAccountapprove": false,
                },
                heading: "Request for approve account ",
                // subtitle: dialogNotifiactionTitelController.text,
                playerIds: [adminTokenId],
                content: "$userName a $defineRole is waiting for your response",
              ))
                  .then((value) {
                MyDialog.sigleButtonDailog(
                    buttonText: "OK",
                    middleText: "Your account is not approve yet ",
                    title: "Wait for account approve",
                    function: () {
                      OneContext().popDialog();
                      Get.back();
                    });
              });
            } else {
              Get.to(() => RapidResponseScreen(
                    isRespospoding: false,
                  ));
            }
          });

          isSignUpLoading.value = false;
          clearSignIpController();
          //Get.to(() => RapidResponseScreen());
        }).catchError((e) {
          Get.snackbar("Error", e.toString());
          isSignUpLoading.value = false;
        });
      }
    } catch (e) {
      isSignUpLoading.value = false;
      print("Error is $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void signOut() {
    auth.signOut().then((value) {
      googleSignout();
    });
  }

  // void googlelogin() {
  //   googleSignIn.signIn().then((userData) {
  //     googleSignInAccount = userData;
  //     print(googleSignInAccount);
  //     Get.to(() => const RapidResponseScreen());
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  void googleSignout() {
    googleSignIn.signOut().then((value) {
      print("Google Sign out");
      Get.offAll(() => DefineRoleScreen());

      //Get.to(() => SigninScreen());
    });
  }

  void updateUserProfileData(
      {String email, String name, int phoneNumber}) async {
    try {
      if (image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user-images')
            .child(users.uid);
        await ref.putFile(image);
        final url = await ref.getDownloadURL();
        print('Url is: $url');
        await firebaseFirestore.collection('Users').doc(users.uid).update({
          'image': url ?? "",
          'name': name ?? "",
          'email': email ?? '',
          'phoneNumber': phoneNumber ?? 0,
        }).then((value) {
          isProfileChange.value = false;
          getUser();
          MyDialog.sigleButtonDailog(
              buttonText: "OK",
              middleText: "Profile change succesfully",
              title: "Profile change",
              function: () {
                OneContext().popDialog();
              });
          //Get.defaultDialog(title: "Profile added");
          print("Data added");

          //Get.put(UserController()).getUser();
          //Get.back();
        });
      } else {
        await firebaseFirestore.collection('Users').doc(users.uid).update({
          //'image': url ?? "",
          'name': name ?? "",
          'email': email ?? '',
          'phoneNumber': phoneNumber ?? 0,
        }).then((value) {
          isProfileChange.value = false;
          getUser();
          MyDialog.sigleButtonDailog(
              buttonText: "OK",
              middleText: "Profile change succesfully",
              title: "Profile change",
              function: () {
                OneContext().popDialog();
              });
        });
      }

      //return true;
    } catch (e) {
      isProfileChange.value = false;
      print("Error is  $e");

      print(e);
      Get.snackbar('Error', e.toString());
      //return false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) {
        firebaseFirestore
            .collection("Users")
            .doc(value.user.uid)
            .get()
            .then((value) {
          print(value.id);
          print(value.data()["isaAccountapprove"]);
          if (value.data()["assignNumber"] != assignNumber) {
            print(
                "assignnumber from firebase is  ${value.data()["assignNumber"]}");
            print("assing number is $assignNumber");
            MyDialog.sigleButtonDailog(
                buttonText: "OK",
                middleText:
                    "Your role is not  $defineRole\n Please Select Your Role Correct ",
                title: "Role Errors",
                function: () {
                  OneContext().popDialog();
                  Get.back();
                });
          } else if (value.data()["isaAccountapprove"] == false) {
            MyDialog.sigleButtonDailog(
                buttonText: "OK",
                middleText: "Your account is not approve yet",
                title: "Account not Approve",
                function: () {
                  OneContext().popDialog();
                });
          } else if (value.data()["assignNumber"] == 111) {
            Get.offAll(() => RapidResponseScreen(
                  isRespospoding: false,
                ));
          } else {
            Get.offAll(() => RapidResponseScreen(
                  isRespospoding: false,
                ));
          }

          print(value.data()["name"]);
        });
        clearSignInController();

        print("login Succesfully");
        isSignInLoading.value = false;
      }).catchError((e) {
        isSignInLoading.value = false;

        Get.snackbar("Error", e.toString());
      });
    } catch (e) {
      isSignInLoading.value = false;

      Get.snackbar(
        "Error signing in",
        e.message,
      );
    }
  }

  void clearSignInController() {
    signinEmailController.clear();
    signinPasswordController.clear();
  }

  void clearSignIpController() {
    signupConfirmPasswordController.clear();
    signupEmailController.clear();
    signupPasswordController.clear();
    signupPhoneNumberController.clear();
    signupUnitCodeController.clear();
    signupUserNameController.clear();
    signupPropertyCodeController.clear();
  }
}
