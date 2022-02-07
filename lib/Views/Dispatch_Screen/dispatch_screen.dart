import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:one_context/one_context.dart';
import 'package:rapid_response/Views/Constants/colors.dart';
import 'package:rapid_response/Views/Rapid_Response/Components/rappid_response_dialog.dart';
import 'package:rapid_response/Views/UserProfile/user_profile.dart';
import 'package:rapid_response/Views/Widgets/my_button.dart';
import 'package:rapid_response/Views/Widgets/smart_button_indicator.dart';

class DispatchScreen extends StatefulWidget {
  static String tag = 'signup-page';

  @override
  _DispatchScreenState createState() => new _DispatchScreenState();
}

class _DispatchScreenState extends State<DispatchScreen>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final availableButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ProgressButton(
        color: MyColors.primary,
        defaultWidget: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
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
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            // leading: BackButton(color: JssColors.judul),
            leading: Container(
              margin: const EdgeInsets.only(left: 16.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: Image.asset('assets/images/home.png'),
                onPressed: () {
                  OneContext().pop();
                },
              ),
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
                    onTap: () {},
                    child: const Icon(
                      Icons.menu,
                      color: MyColors.grey_3,
                      size: 26.0,
                    ),
                  )),
            ],
          ),
          backgroundColor: Colors.white,
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: MyColors.grey_2,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    flexibleSpace: Column(
                      children: [
                        TabBar(
                          controller: tabController,
                          isScrollable: true,
                          indicatorWeight: 2,
                          indicatorColor: MyColors.primary,
                          labelColor: MyColors.primary,
                          unselectedLabelColor: Colors.grey,
                          tabs: <Widget>[
                            Tab(
                              icon: Image.asset(
                                'assets/images/account.png',
                                color: tabController.index == 0
                                    ? MyColors.primary
                                    : MyColors.grey,
                              ),
                              text: 'Change Account',
                            ),
                            Tab(
                              icon: Image.asset('assets/images/dispatch.png',
                                  color: tabController.index == 1
                                      ? MyColors.primary
                                      : MyColors.grey),
                              text: 'Dispatch Msg.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(controller: tabController, children: [
                const ProfileScreen(),
                Container(
                    child: Column(
                  children: [
                    buildlist('Avaliability', 'assets/images/clock.png'),
                    buildlist('Preplans', 'assets/images/preplans.png'),
                    buildlist(
                        'Dispatch Settings', 'assets/images/dispatch.png'),
                    buildlist(
                        'Manage Courtesy Message', 'assets/images/chat.png'),
                    buildlist(
                        'Send Dispatch Alerts', 'assets/images/alerts.png'),
                    buildlist('Manage Accounts', 'assets/images/account.png'),
                    buildlist('Reset Dashboard', 'assets/images/reset.png'),
                    buildlist('Settings', 'assets/images/settings.png'),
                  ],
                ))
              ]),
            ),
          ),
        ));
  }

  Widget buildlist(name, image) {
    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 2),
        color: MyColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 4),
                        child: Visibility(child: Image.asset(image))),
                    GestureDetector(
                        onTap: () {},
                        child: Text(name,
                            style: const TextStyle(color: MyColors.secondary)))
                  ],
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      color: MyColors.grey,
                    ),
                  ),
                ))
          ],
        ));
  }
}
