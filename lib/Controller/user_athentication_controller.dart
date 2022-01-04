import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_context/one_context.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rapid_response/Model/user_model.dart';
import 'package:rapid_response/Views/Authentication/role_define_screen.dart';
import 'package:rapid_response/Views/Authentication/sign_screen.dart';
import 'package:rapid_response/Views/Rapid_Response/rapid_response.dart';
import 'package:intl/intl.dart';

class UserAthenticationController extends GetxController {
  @override
  void onInit() {
    //sendAlertto(333);
    firebaseUser.bindStream(auth.authStateChanges());
    //googleSignInAccounts.bindStream(googleSignIn..s);
    print("user is $googleSignInAccount");
    //googleSignInAccount.
    super.onInit();
  }

  //TextEditingController for SignUp
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupUserNameController = TextEditingController();
  TextEditingController signupUnitCodeController = TextEditingController();
  TextEditingController signupPhoneNumberController = TextEditingController();
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

//edit profile Controller
  TextEditingController editmail = TextEditingController();
  TextEditingController editPhonenumber = TextEditingController();
  //Message controller
  TextEditingController messageController = TextEditingController();

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
      print("my event data is ${event.notification.additionalData}");
      eventCreatorId = event.notification.additionalData["eventCreatorId"];
      chatID = event.notification.additionalData["broadCastChatID"];

      print("Notificaiton Received");
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

      firebaseFirestore
          .collection("Users")
          .doc(users.uid)
          .collection("Notifications")
          .add({
        "notificationBody": event.notification.body,
        "notificationtitle": event.notification.title,
        "responders": 0,
        "date": formattedDate
      });
      //Get.to(() => ConfirmClients());
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print("i am here");
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
      print("my user email is ${user.email} ");
    } catch (e) {
      print(e);
    }
  }

// Broadcast Methode
  void sendMessage(String txtMessage) {
    firebaseFirestore
        .collection("Users")
        .doc(eventCreatorId)
        .collection("BroadcastChat")
        .doc(chatID)
        .collection("Conversation")
        .add({"txtMessage": txtMessage}).then((value) {
      messageController.clear();
      print("message sent");
    }).catchError((e) {
      print("message not send error is $e");
    });
  }

  //Google sign In Methode
  void googleLogin() async {
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
      "phoneNumber": authResult.user.phoneNumber,
      "role": defineRole,
      "assignNumber": assignNumber,
    };
    var now = DateTime.now();
    var _updateTime = DateTime(
        now.year, now.month, now.day - 1, now.hour, now.minute, now.second);
    if (authResult.additionalUserInfo.isNewUser) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(authResult.user.uid)
          .set(userdata)
          .then((value) async {
        Get.to(SigninScreen());
      });
    } else {
      Get.offAll(RapidResponseScreen(
        isRespospoding: false,
      ));
    }
  }

  //add notifiaction data to firebase
  void addNotification() {}

  // Send Notification methode
  sendNotification() {
    print("title is ${dialogNotifiactionTitelController.text}");
    // print("user token is${userController.userToken}");
    //for(int i = 0; i<userAthenticationController.herlperList.length; i++){}

    firebaseFirestore
        .collection("Users")
        .doc(users.uid)
        .collection("BroadcastChat")
        .add({"eventTitle": dialogNotifiactionTitelController.text}).then(
            (value) {
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
            .add({"txtMessage": dialogNotifiactionController.text});
      }).then((value) {
        dialogNotifiactionController.clear();
        dialogNotifiactionTitelController.clear();
        OneContext().popDialog();
      });
    });

    print("back");
    Get.back();
  }

  void sendAlertDialog(int assignumber) {
    sendNotifocationto.bindStream(sendAlertto(assignumber));
    // getIdfornotificaiton.bindStream(getIdtoSendNotificaiton(assignumber));
  }

  Stream<List<String>> sendAlertto(int assignNumber) {
    if (assignNumber != 0) {
      return FirebaseFirestore.instance
          .collection('Users')
          .where("assignNumber", isEqualTo: assignNumber)
          //.orderBy('time', descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        print(query.docs.length);
        List<String> retVal = List();
        query.docs.forEach((element) {
          print(element.data()["tokenId"]);

          retVal.add(element.data()["tokenId"]);
        });

        print(' my  sdj lenght is ${retVal.length}');
        return retVal;
      });
    } else {
      return FirebaseFirestore.instance
          .collection('Users')
          //.where("assignNumber", isEqualTo: assignNumber)
          //.orderBy('time', descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        print(query.docs.length);
        List<String> retVal = List();
        query.docs.forEach((element) {
          print(element.data()["tokenId"]);

          retVal.add(element.data()["tokenId"]);
        });

        print(' my  sdj lenght is ${retVal.length}');
        return retVal;
      });
    }
  }

  //final UserCredential authResult =  await auth.signInWithCredential(credential);

  void signUP({
    String email,
    String password,
    String userName,
    String unitCode,
    int phoneNumber,
    String confirmPassword,
  }) async {
    try {
      var status = await OneSignal.shared.getDeviceState();
      String tokenID = status.userId;
//       OSPermissionSubscriptionState status = OneSignal.getPermissionSubscriptionState();
// status.getSubscriptionStatus().getUserId();

      // String UUID = OneSignal.getPermissionSubscriptionState().getSubscriptionStatus().getUserId()

      await auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        firebaseFirestore.collection("Users").doc(value.user.uid).set({
          "name": userName,
          "email": email,
          "unitCode": unitCode,
          "phoneNumber": phoneNumber,
          "role": defineRole,
          "assignNumber": assignNumber,
          "roleImage": roleImage,
          "tokenId": tokenID + value.user.uid,
          "image":
              "https://firebasestorage.googleapis.com/v0/b/rapid-response-app-ae749.appspot.com/o/profile-deleted.png?alt=media&token=30a9321f-ff58-4f80-899e-3c6db7896746"
        });

        print("account Created");
        isSignUpLoading.value = false;
        clearSignIpController();
        Get.to(() => RapidResponseScreen());
      }).catchError((e) {
        Get.snackbar("Error", e.toString());
        isSignUpLoading.value = false;
      });
    } catch (e) {
      isSignUpLoading.value = false;
      print("Error is $e");
      Get.snackbar("Error", e.toString());
    }
  }

  void signOut() {
    auth.signOut().then((value) {
      Get.to(() => DefineRoleScreen());
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
      print("Sign out");
      Get.to(() => SigninScreen());
    });
  }

  void updateUserProfileData(
      {String email, String name, int phoneNumber}) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child('user-images').child(users.uid);
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
        Get.defaultDialog(title: "Profile added");
        print("Data added");

        //Get.put(UserController()).getUser();
        //Get.back();
      });

      //return true;
    } catch (e) {
      isProfileChange.value = false;

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
        print("login Succesfully");
        isSignInLoading.value = false;
        clearSignInController();
        Get.to(() => RapidResponseScreen(
              isRespospoding: false,
            ));
        //getUser();

        // Get.to(BDObottomNaveBar());
      });
    } catch (e) {
      isSignInLoading.value = false;

      Get.snackbar(
        "Error signing in",
        e.message,
        //snackPosition: SnackPosition.BOTTOM,
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
  }
}
