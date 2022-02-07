import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';

import 'Bindings/auth_bindings.dart';
import 'SizeConfig/size_config.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Views/Splash_Page/splash_screen.dart';
import 'container_tile.dart';
import 'my_screen.dart';

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
  UserAthenticationController userAthenticationController =
      Get.put(UserAthenticationController());
  @override
  void initState() {
    super.initState();
    userAthenticationController.configOneSignel();
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
            home: SplashScreen()
            //OnboardPage());

            //const PrayerTimeScreen(),
            //ProvidedStylesExample(),
            //  ContainerTile(),
            );
      });
    });
  }
}
