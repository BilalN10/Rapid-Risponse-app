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

class UserAthenticationController extends GetxController {
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

  int assignNumber = 0;
  String defineRole = "";
  String roleImage;

  TextEditingController editmail = TextEditingController();

  TextEditingController editPhonenumber = TextEditingController();
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Rxn<User> firebaseUser = Rxn<User>();
  User get users => firebaseUser.value;
  File image;
  Rx<List<String>> sendNotifocationto = Rx<List<String>>([]);
  List<String> get sendNotifoactions => sendNotifocationto.value;

  Rx<List<String>> getIdfornotificaiton = Rx<List<String>>([]);
  List<String> get getUserTogetNotification => getIdfornotificaiton.value;

  Rxn<GoogleSignInAccount> googleSignInAccounts = Rxn<GoogleSignInAccount>();
  GoogleSignInAccount get googleSignInAccount => googleSignInAccounts.value;
  set googleSignInAccount(GoogleSignInAccount name) {
    googleSignInAccounts.value = name;
  }

  Rx<UserModel> usermodel = UserModel().obs;
  UserModel get user => usermodel.value;
  set user(UserModel value) => usermodel.value = value;

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

  @override
  void onInit() {
    //sendAlertto(333);
    firebaseUser.bindStream(auth.authStateChanges());
    //googleSignInAccounts.bindStream(googleSignIn..s);
    print("user is $googleSignInAccount");
    //googleSignInAccount.
    super.onInit();
  }

  //TextEditingController for Sign in

  TextEditingController signinEmailController = TextEditingController();
  TextEditingController signinPasswordController = TextEditingController();

  RxBool isSignUpLoading = false.obs;
  RxBool isSignInLoading = false.obs;
  RxBool isProfileChange = false.obs;

  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  //GoogleSignInAccount googleSignInAccount;
  //GoogleSignIn googleSignIn = GoogleSignIn();

  void googleSignInn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  }

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
        // Get.find<UserController>().user   =
        //     await DatabaseServices().getUser(auth.u.uid);
        //  FirebaseFirestore.instance.collection("Users").
        //  doc(authResult.user.uid).set(userdata).then((value) {
        //    for(int i=0; i<5; i++){
        //      FirebaseFirestore.instance.collection("Users")
        //          .doc(authResult.user.uid).collection(ADS_COLLECTION)
        //          .doc(i.toString()).set({
        //        ADS_UPDATE_TIME:_updateTime.toString()
        //      });
        //    }

        //    Get.offAll(WelcomeScreen());
        //  } );
        // Get.offAll(WelcomeScreen());
        Get.to(SigninScreen());
      });
    } else {
      Get.offAll(const RapidResponseScreen());
    }
  }
  // void getU(String number)
  // {

  // }
  sendNotification() {
    // print("user token is${userController.userToken}");
    //for(int i = 0; i<userAthenticationController.herlperList.length; i++){}
    OneSignal.shared
        .postNotification(OSCreateNotification(
      additionalData: {
        'data': 'this is our data',
      },
      subtitle: 'Flutter in depth',
      playerIds: sendNotifoactions,
      content: dialogNotifiactionController.text,
    ))
        .then((value) {
      for (int i = 0; i < getUserTogetNotification.length; i++) {
        firebaseFirestore
            .collection("Users")
            .doc(getUserTogetNotification[i])
            .collection("Notifications")
            .add({"notificatiton": dialogNotifiactionController.text});
      }
      dialogNotifiactionController.clear();

      OneContext().popDialog();

      print("back");
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  void sendAlertDialog(int assignumber) {
    sendNotifocationto.bindStream(sendAlertto(assignumber));
    getIdfornotificaiton.bindStream(getIdtoSendNotificaiton(assignumber));
  }

  Stream<List<String>> getIdtoSendNotificaiton(int assignNumber) {
    print("my Number ia $assignNumber");
    print("enter in add function");
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
          print(element.id);

          retVal.add(element.id);
        });

        print(' my  id  lenght is ${retVal.length}');
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
          print(element.id);

          retVal.add(element.id);
        });

        print(' my  id  lenght is ${retVal.length}');
        return retVal;
      });
    }
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
        Get.to(() => const RapidResponseScreen());
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
