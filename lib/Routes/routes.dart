import 'package:flutter/material.dart';
import 'package:rapid_response/Views/Dispatch_Screen/dispatch_screen.dart';
import 'package:rapid_response/Views/Incident_calls/incident_calls_screen.dart';
import 'package:rapid_response/Views/Rapid_Response/rapid_response.dart';
import 'package:rapid_response/Views/ResponseScreen/response_screen.dart';
import 'package:rapid_response/Views/TaskScreen/compnent/assign_task_screen.dart';
import 'package:rapid_response/Views/TaskScreen/task_screen.dart';
import 'package:rapid_response/Views/UserProfile/user_profile.dart';

class Routes {
  Routes._();

  //static variables
  static const String signin_screen = '/screen/sign_in';
  static const String signup_screen = '/screen/sign_up';
  static const String splash_screen = '/screen/splash';
  static const String facility_code_screen = '/screen/facility_code';
  static const String confirm_screen = '/screen/confirm';
  static const String reset_password_screen = '/screen/reset_password';
  static const String rapid_response_screen =
      '/Views/Rapid_Response/rapid_response';
  static const String dispatch_screen = '/screen/dispatch';
  static const String profile_screen = '/screen/profile';
  static const String incident_calls_screen = '/screen/incident_calls';
  static const String task_screen = '/Views/TaskScreen/task_screen';
  static const String assign_task_screen = '/screen/assign_task';
  static const String response_screen = '/screen/response';

  static final routes = <String, WidgetBuilder>{
    //signin_screen: (BuildContext context) => SignInScreen(),
    //signup_screen: (BuildContext context) => SignUpScreen(),
    //splash_screen: (BuildContext context) => SplashScreen(),
    //facility_code_screen: (BuildContext context) => FacilityCodeScreen(),
    //confirm_screen: (BuildContext context) => ConfirmScreen(),
    //reset_password_screen: (BuildContext context) => ResetPasswordScreen(),
    rapid_response_screen: (BuildContext context) => RapidResponseScreen(),
    dispatch_screen: (BuildContext context) => DispatchScreen(),
    profile_screen: (BuildContext context) => const ProfileScreen(),
    incident_calls_screen: (BuildContext context) => IncidentCallsScreen(),
    task_screen: (BuildContext context) => const TaskScreen(),
    assign_task_screen: (BuildContext context) => TaskAssignScreen(),
    response_screen: (BuildContext context) => MapScreen(),
  };
}
