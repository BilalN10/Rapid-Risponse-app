import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'Bindings/auth_bindings.dart';
import 'SizeConfig/size_config.dart';
import 'Views/Authentication/role_define_screen.dart';
import 'Views/Splash_Page/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'google_signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configOneSignel();
  }

  void configOneSignel() {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("4917de9f-6a26-43c2-92f6-92c83653d49e");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   print("Accepted permission: $accepted");
    // });
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      print("notification recieved");
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return GetMaterialApp(
            builder: OneContext().builder,
            initialBinding: AuthBinding(),
            title: "Rapid Response",
            theme: ThemeData(
              fontFamily: 'Montserrat',
            ),
            debugShowCheckedModeBanner: false,
            home:
                //DefineRoleScreen()

                /// SignIN()
                //GoogleMaps()
                SplashScreen()
            //HomePage()
            //DateTimePiker()
            //AlarmPage(),
            //UploadFileToFireBase(),
            );
      });
    });
  }
}
