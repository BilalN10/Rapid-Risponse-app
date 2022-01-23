import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rapid_response/Controller/incident_call_contoller.dart';
import 'package:rapid_response/Controller/user_athentication_controller.dart';
import 'package:rapid_response/Model/bottom_navbar_model.dart';
import 'package:rapid_response/Model/item_model.dart';
import 'package:rapid_response/SizeConfig/size_config.dart';
import 'package:rapid_response/Views/Chat/doccotor_message.dart';
import 'package:rapid_response/Views/ClosedEvents/closed_events.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Constants/mydialog.dart';
import 'package:rapid_response/Views/Dispatch_Screen/dispatch_screen.dart';
import 'package:rapid_response/Views/GoogleMap/google_map_Screen.dart';
import 'package:rapid_response/Views/GoogleMap/google_map_screen.dart';
import 'package:rapid_response/Views/Incident_calls/incident_calls_screen.dart';
import 'package:rapid_response/Views/NotificationForApproveAccount/approve_notificatio_screen.dart';
import 'package:rapid_response/Views/ResponseScreen/response_screen.dart';
import 'package:rapid_response/Views/TaskScreen/compnent/assign_task_screen.dart';
import 'package:rapid_response/Views/TaskScreen/task_screen.dart';
import 'package:rapid_response/Views/UserProfile/user_profile.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/progress_indicator_widget.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'Components/rappid_response_dialog.dart';

class RapidResponseScreen extends StatefulWidget {
  RapidResponseScreen({Key key, this.isRespospoding}) : super(key: key);
  bool isRespospoding;

  static String tag = 'signup-page';

  @override
  _RapidResponseScreenState createState() => _RapidResponseScreenState();
}

class _RapidResponseScreenState extends State<RapidResponseScreen>
    with TickerProviderStateMixin {
  List<String> tokenList = [
    "ad00ced2-6b8e-11ec-82e0-6ea9afad054chv6UTiXwoMSNx1G3Icd7G5jV9hI2"
  ];
  UserAthenticationController userAthenticationController =
      Get.find<UserAthenticationController>();

  TabController tabController;
  int selectedIndex = 0;
  bool isAvalailable = false;
  String avaliableStatus = "";

  @override
  void initState() {
    super.initState();
    userAthenticationController.getUser();
    print("user data is ${userAthenticationController.googleSignInAccount}");

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final availableButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ProgressButton(
        color: MyColors.primary,
        defaultWidget: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Expanded(
                  flex: 1,
                  child: Text(
                    "Available",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: MyColors.white),
                  )),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/images/checklist_white.png'),
                ),
              ),
            ],
          ),
        ),
        progressWidget: const SmartButtonIndicatorWidget(),
        borderRadius: 12,
        type: ProgressButtonType.Flat,
        height: 56,
        onPressed: () async {
          OneContext().showDialog(builder: (BuildContext context) {
            return const RapidResponseDialog();
          });
        },
      ),
    );
    // final GlobalKey<ScaffoldState> _scaffoldKey =
    //     new GlobalKey<ScaffoldState>();

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            key: _drawerKey,
            drawer: Drawer(
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
                        GetX<UserAthenticationController>(
                            init: Get.find<UserAthenticationController>(),
                            builder: (cont) {
                              return Column(
                                children: [
                                  Container(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      height: 10 * SizeConfig.heightMultiplier,
                                      width: 20 * SizeConfig.widthMultiplier,
                                      imageUrl: cont.user.image,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          const SmartDoubleBounceIndicatorWidget(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/profile-deleted.png',
                                              fit: BoxFit.cover),
                                    ),
                                  )),
                                  SizedBox(
                                    height: 1 * SizeConfig.heightMultiplier,
                                  ),
                                  Text(
                                    cont.user.name,
                                    style: TextStyle(
                                        color: MyColors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              );
                            }),
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
                  // ListTile(
                  //   title: const Text('Dispatch Screen'),
                  //   onTap: () {
                  //     Get.to(() => DispatchScreen());
                  //     // OneContext().pushNamed(Routes.dispatch_screen);
                  //   },
                  // ),
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
                  // ListTile(
                  //   title: const Text('Manage accounts'),
                  //   onTap: () {
                  //     Get.to(() => TaskAssignScreen());
                  //     // OneContext().pushNamed(Routes.facility_code_screen);
                  //   },
                  // ),
                  ListTile(
                    title: const Text('Manage accounts'),
                    onTap: () {
                      if (userAthenticationController.user.assignNumber ==
                          111) {
                        Get.to(() => TaskAssignScreen());
                      } else {
                        MyDialog.sigleButtonDailog(
                            title: "For Admin",
                            middleText: "This feature is only for addmins",
                            buttonText: "OK",
                            function: () {
                              OneContext().popDialog();
                            });
                      }
                    },
                  ),
                  // Obx(
                  //   () => userAthenticationController.user.assignNumber == 111
                  //       ? ListTile(
                  //           title: const Text('Approve account notificaiton'),
                  //           onTap: () {
                  //             Get.to(() => ApporveNotificationScreen());
                  //           },
                  //         )
                  //       : const SizedBox(),
                  // ),
                  ListTile(
                    title: const Text('Approve account notificaiton'),
                    onTap: () {
                      if (userAthenticationController.user.assignNumber ==
                          111) {
                        Get.to(() => ApporveNotificationScreen());
                      } else {
                        MyDialog.sigleButtonDailog(
                            title: "For Admin",
                            middleText: "This feature is only for addmins",
                            buttonText: "OK",
                            function: () {
                              OneContext().popDialog();
                            });
                      }
                    },
                  ),
                  // ListTile(
                  //   title: const Text('Reponse Screen'),
                  //   onTap: () {
                  //     Get.to(() => MapScreen());
                  //     // OneContext().pushNamed(Routes.response_screen);
                  //   },
                  // ),
                  // ListTile(
                  //   title: const Text('Maps'),
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: ((context) => TaskAssignScreen())));
                  //     //Get.to(() => GooleMapsScreen());
                  //     // OneContext().pushNamed(Routes.facility_code_screen);
                  //   },
                  // ),
                  ListTile(
                    title: const Text('Closed Event'),
                    onTap: () {
                      if (userAthenticationController.user.assignNumber ==
                          111) {
                        Get.to(() => ClosedEventsScreen());
                      } else {
                        MyDialog.sigleButtonDailog(
                            title: "For Admin",
                            middleText: "This feature is only for addmins",
                            buttonText: "OK",
                            function: () {
                              OneContext().popDialog();
                            });
                      }
                    },
                  ),

                  // Obx(() =>
                  //     // : SizedBox(),
                  //     ),
                  ListTile(
                    title: const Text('Sign out'),
                    onTap: () {
                      userAthenticationController.signOut();
                      //Get.to(() => MyHomePage());
                      // OneContext().pushNamed(Routes.facility_code_screen);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              // leading: BackButton(color: JssColors.judul),
              leading: Container(
                margin: const EdgeInsets.only(left: 16.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                // child: IconButton(
                //   icon: Image.asset('assets/images/home.png'),
                //   onPressed: () {
                //     //OneContext().pushNamed(LoginScreen.tag);
                //   },
                // ),
              ),
              title: const Text(
                "Rapid Response",
                style: TextStyle(
                    color: MyColors.secondary, fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        //Scaffold.of(context).openEndDrawer();
                        //scaffoldKey.currentState.openDrawer(),
                        _drawerKey.currentState.openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        color: MyColors.grey_3,
                        size: 26.0,
                      ),
                    )),
              ],
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3 * SizeConfig.widthMultiplier),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                child: Column(
                              children: <Widget>[
                                //SizedBox(height: 16.0),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 6, right: 6),
                                    child: availableButton),
                                //SizedBox(height: 16.0),
                                const SizedBox(height: 10.0),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.0, right: 0.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Responding to:',
                                              style: TextStyle(
                                                  color: MyColors.secondary,
                                                  fontWeight: FontWeight.bold)),
                                        )),
                                    //widget.isRespospoding
                                    Obx(() => userAthenticationController
                                            .isResponding.value
                                        ? const Text(
                                            "Please Confirm your Availability",
                                            style: TextStyle(
                                                color: MyColors.primary,
                                                fontWeight: FontWeight.bold))
                                        : const SizedBox()),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Obx(
                                  () => userAthenticationController
                                              .isAvalailable.value &&
                                          userAthenticationController
                                              .isResponding.value
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "($avaliableStatus) you can go for a chat"),
                                            Container(
                                              height: 5 *
                                                  SizeConfig.heightMultiplier,
                                              width: 25 *
                                                  SizeConfig.widthMultiplier,
                                              child: ProgressButton(
                                                color: MyColors.primary,
                                                defaultWidget: Container(
                                                  child: Text(
                                                    "Go for Chat",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 1.6 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                progressWidget:
                                                    const SmartButtonIndicatorWidget(),
                                                borderRadius: 12,
                                                type: ProgressButtonType.Flat,
                                                height: 56,
                                                onPressed: () async {
                                                  userAthenticationController
                                                      .availabeResponderMthode(
                                                          avaliableStatus);

                                                  // OneContext().showDialog(builder:
                                                  //     (BuildContext context) {
                                                  //   return RapidResponseDialog(
                                                  //       blur: false);
                                                  // });
                                                  //Get.to(() => const FacilityCode());
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ),
                                const SizedBox(height: 10.0),

                                Container(child: list()),
                                SizedBox(
                                    height: 10 * SizeConfig.widthMultiplier),
                                Container(
                                  //color: Colors.amber,
                                  height: 10 * SizeConfig.heightMultiplier,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: bottomNavBarModelList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                            });
                                          },
                                          child: Container(
                                            //margin: EdgeInsets.all(10),
                                            width:
                                                25 * SizeConfig.widthMultiplier,
                                            //color: Colors.green,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 6 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  width: 25 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  // decoration: BoxDecoration(
                                                  //     image: DecorationImage(
                                                  //         image: AssetImage(
                                                  //             bottomNavBarModelList[
                                                  //                     index]
                                                  //                 .img)

                                                  //                 )),
                                                  child: Image.asset(
                                                    bottomNavBarModelList[index]
                                                        .img,
                                                    color:
                                                        selectedIndex == index
                                                            ? MyColors.primary
                                                            : MyColors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  bottomNavBarModelList[index]
                                                      .title,
                                                  style: TextStyle(
                                                    color:
                                                        selectedIndex == index
                                                            ? MyColors.primary
                                                            : MyColors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                ),
                                                Container(
                                                  height: 0.3 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  width: 24 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          selectedIndex == index
                                                              ? MyColors.primary
                                                              : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                    height: 5 * SizeConfig.heightMultiplier),
                                Obx(
                                  () => userAthenticationController
                                                  .user.assignNumber ==
                                              333 ||
                                          userAthenticationController
                                                  .user.assignNumber ==
                                              444
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            userAthenticationController
                                                        .user.assignNumber ==
                                                    111
                                                ? Container(
                                                    width: 47 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    child: ProgressButton(
                                                      color: MyColors.grey,
                                                      defaultWidget: Container(
                                                        child: Text(
                                                          "All Calls",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontSize: 1.6 *
                                                                  SizeConfig
                                                                      .textMultiplier,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      progressWidget:
                                                          const SmartButtonIndicatorWidget(),
                                                      borderRadius: 12,
                                                      type: ProgressButtonType
                                                          .Flat,
                                                      height: 56,
                                                      onPressed: () async {
                                                        OneContext().showDialog(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                          return const RapidResponseDialog(
                                                              blur: false);
                                                        });
                                                      },
                                                    ),
                                                  )
                                                : SizedBox(),
                                            Container(
                                              width: 47 *
                                                  SizeConfig.widthMultiplier,
                                              child: ProgressButton(
                                                color: MyColors.primary,
                                                defaultWidget: Container(
                                                  child: Text(
                                                    "Responder",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 1.6 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                progressWidget:
                                                    const SmartButtonIndicatorWidget(),
                                                borderRadius: 12,
                                                type: ProgressButtonType.Flat,
                                                height: 56,
                                                onPressed: () async {
                                                  OneContext().showDialog(
                                                      builder: (BuildContext
                                                          context) {
                                                    return const RapidResponseDialog(
                                                        blur: false);
                                                  });
                                                  //Get.to(() => const FacilityCode());
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                ),

                                SizedBox(
                                  height: 5 * SizeConfig.heightMultiplier,
                                ),
                                //Text("hello"),

                                // Container(
                                //   height: 12 * SizeConfig.heightMultiplier,
                                //   child: ListView.builder(
                                //       itemBuilder: (context, index) {
                                //     return Container(
                                //       width: 4 * SizeConfig.widthMultiplier,
                                //       color: Colors.amber,
                                //     );
                                //   }),
                                // ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Align(
                  //     alignment: Alignment.center,
                  //     child: GestureDetector(
                  //         onTap: () {

                  //         },
                  //         child: ResponseWidget()))
                ],
              ),
            )));
  }

  Widget list() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemData.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpandableNotifier(
            child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(itemData[index]),
                  expanded: buildExpanded1(itemData[index]),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  buildCollapsed1(ItemModel itemData, {border = true}) {
    return Builder(
      builder: (context) {
        var controller = ExpandableController.of(context, required: true);
        return GestureDetector(
          onTap: () {
            controller.toggle();
          },
          child: Container(
            height: 6 * SizeConfig.heightMultiplier,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: itemData.isActive
                    ? MyColors.active_box
                    : MyColors.inactive_box,
                border: Border.all(
                    color: border
                        ? MyColors.grey
                        : itemData.isActive
                            ? MyColors.active_box
                            : MyColors.inactive_box),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Visibility(
                              visible: itemData.selected,
                              child: controller.expanded
                                  ? Image.asset(
                                      'assets/images/checklist-outline.png')
                                  : Image.asset(
                                      'assets/images/checklist-red.png'))),
                      Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Visibility(
                              visible: !itemData.selected && itemData.warning,
                              child: Image.asset(
                                  'assets/images/warning-sign.png'))),
                      GestureDetector(
                          onTap: () {
                            controller.toggle();
                          },
                          child: Text(itemData.headerItem,
                              style: TextStyle(
                                  color: itemData.selected
                                      ? MyColors.primary
                                      : MyColors.secondary)))
                    ],
                  )),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  itemData.selected = false;
                                  itemData.selectedItem = '';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                                decoration: BoxDecoration(
                                    color: itemData.selected
                                        ? MyColors.primary
                                        : itemData.isActive
                                            ? MyColors.active_box
                                            : MyColors.inactive_box,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Row(
                                  children: [
                                    Visibility(
                                        visible: itemData.selected,
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Image.asset(
                                                'assets/images/close.png'),
                                          ),
                                        )),
                                    Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(itemData.selectedItem ?? '',
                                            style: TextStyle(
                                                color: MyColors.white,
                                                fontSize: 11)),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                      Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: itemData.responderBadge > 0
                                ? itemData.warning
                                    ? Colors.black
                                    : MyColors.primary
                                : MyColors.grey,
                            shape: BoxShape.circle),
                        child: Text(
                          itemData.responderBadge.toString(),
                          style: TextStyle(color: MyColors.white),
                        ),
                      ),
                    ],
                  ))
                ]),
          ),
        );
      },
    );
  }

  buildExpanded1(ItemModel itemData) {
    return Container(
      // height: 5 * SizeConfig.screenHeight,
      decoration: BoxDecoration(
          color:
              itemData.isActive ? MyColors.active_box : MyColors.inactive_box,
          border: Border.all(color: MyColors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCollapsed1(itemData, border: false),
            Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemData.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            itemData.selected = true;
                            itemData.selectedItem = itemData.list[index];
                            avaliableStatus = itemData.selectedItem;
                            userAthenticationController.isAvalailable.value =
                                true;
                            //print(itemData.selectedItem);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(itemData.list[index]),
                        ));
                  }),
            )
          ]),
    );
  }

  //TODO : Change Data
  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
        headerItem: 'Medical',
        isActive: true,
        list: ['Elevator', 'Unavailable', 'Access Control', 'Beg/AED', 'Unit'],
        selected: false,
        selectedItem: '',
        responderBadge: 3),
    ItemModel(
        headerItem: 'Fire',
        isActive: false,
        list: [],
        selected: false,
        selectedItem: '',
        responderBadge: 0),
    ItemModel(
        headerItem: 'Intruder/Trespasser',
        isActive: false,
        list: [
          'Access Control',
          'Cameras',
          'Floors',
          'Garage',
          'Stairwell',
          'Unavailable'
        ],
        selected: false,
        warning: true,
        selectedItem: '',
        responderBadge: 1),
    ItemModel(
        headerItem: 'Flood/Escaping Water',
        isActive: false,
        list: [],
        selected: false,
        selectedItem: '',
        responderBadge: 0),
    ItemModel(
        headerItem: 'Active Assailant',
        isActive: false,
        list: [],
        selected: false,
        selectedItem: '',
        responderBadge: 0),
    ItemModel(
        headerItem: 'Outage',
        isActive: false,
        list: [],
        selected: false,
        selectedItem: '',
        responderBadge: 0),
    ItemModel(
        headerItem: 'Sever Weather',
        isActive: false,
        list: [],
        selected: false,
        selectedItem: '',
        responderBadge: 0),
    // ItemModel(
    //     headerItem: 'Other',
    //     isActive: false,
    //     list: [],
    //     selected: false,
    //     selectedItem: '',
    //     responderBadge: 0),
    // ItemModel(
    //     headerItem: 'Other',
    //     isActive: false,
    //     list: [],
    //     selected: false,
    //     selectedItem: '',
    //     responderBadge: 0),
    // ItemModel(
    //     headerItem: 'Other',
    //     isActive: false,
    //     list: [],
    //     selected: false,
    //     selectedItem: '',
    //     responderBadge: 0),
    // ItemModel(
    //     headerItem: 'Other',
    //     isActive: false,
    //     list: [],
    //     selected: false,
    //     selectedItem: '',
    //     responderBadge: 0),
    // ItemModel(
    //     headerItem: 'Other',
    //     isActive: false,
    //     list: [],
    //     selected: false,
    //     selectedItem: '',
    //     responderBadge: 0),
  ];
}
