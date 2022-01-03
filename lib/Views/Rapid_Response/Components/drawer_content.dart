import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Dispatch_Screen/dispatch_screen.dart';
import 'package:rapid_response/Views/GoogleMap/google_map_screen.dart';
import 'package:rapid_response/Views/Incident_calls/incident_calls_screen.dart';
import 'package:rapid_response/Views/ResponseScreen/response_screen.dart';
import 'package:rapid_response/Views/TaskScreen/compnent/assign_task_screen.dart';
import 'package:rapid_response/Views/TaskScreen/task_screen.dart';
import 'package:rapid_response/Views/UserProfile/user_profile.dart';
import 'package:rapid_response/Views/Widgets/progress_indicator_widget.dart';

class DrawerContend extends StatelessWidget {
  const DrawerContend({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: MyColors.primary,
            ),
            child: Container(
                child: Row(
              children: [
                Column(
                  children: [
                    Container(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(250),
                      child: CachedNetworkImage(
                        imageUrl: '',
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const SmartDoubleBounceIndicatorWidget(),
                        errorWidget: (context, url, error) => Image.asset(
                            'assets/images/profile-deleted.png',
                            fit: BoxFit.cover),
                      ),
                    )),
                    const Text(
                      'Montana',
                      style: TextStyle(
                          color: MyColors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            )),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Get.to(() => ProfileScreen());
              // OneContext().pushNamed(Routes.profile_screen);
            },
          ),
          ListTile(
            title: const Text('Dispatch Screen'),
            onTap: () {
              Get.to(() => DispatchScreen());
              // OneContext().pushNamed(Routes.dispatch_screen);
            },
          ),
          ListTile(
            title: const Text('Incident Calls Screen'),
            onTap: () {
              Get.to(() => IncidentCallsScreen());

              //  OneContext().pushNamed(Routes.incident_calls_screen);
            },
          ),
          ListTile(
            title: const Text('Task Screen'),
            onTap: () {
              Get.to(() => TaskScreen(
                  //key: _drawerKey,
                  ));

              // OneContext().pushNamed(Routes.task_screen);
            },
          ),
          ListTile(
            title: const Text('Assign Task'),
            onTap: () {
              Get.to(() => TaskAssignScreen());
              // OneContext().pushNamed(Routes.facility_code_screen);
            },
          ),
          ListTile(
            title: const Text('Reponse Screen'),
            onTap: () {
              Get.to(() => MapScreen());
              // OneContext().pushNamed(Routes.response_screen);
            },
          ),
          ListTile(
            title: const Text('Maps'),
            onTap: () {
              Get.to(() => GooleMapsScreen());
              // OneContext().pushNamed(Routes.facility_code_screen);
            },
          ),
        ],
      ),
    );
  }
}
