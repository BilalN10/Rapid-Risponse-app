import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProvidedStylesExample extends StatefulWidget {
  final BuildContext menuScreenContext;
  const ProvidedStylesExample({Key key, this.menuScreenContext})
      : super(key: key);

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
      // ExampleHomePage(),
      // MatchesScreen(),
      // ChatScreen(),
      // // ExampleHomePage(),
      // ExampleHomePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
          size: 35,
        ),
        title: "Home",
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.search,
          size: 35,
        ),
        title: ("Search"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            // initialRoute: '/',
            // routes: {
            //   '/first': (context) => LoginPage(),
            //   '/second': (context) => RegisterScreen(),
            // },
            ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add_circle_sharp,
          size: 35,
        ),
        title: ("Messages"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: '/',
          // routes: {
          //   '/first': (context) => LoginPage(),
          //   '/second': (context) => RegisterScreen(),
          // },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.settings,
          size: 35,
        ),
        title: ("Settings"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            // initialRoute: '/',
            // routes: {
            //   '/first': (context) => LoginPage(),
            //   '/second': (context) => RegisterScreen(),
            // },
            ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.settings,
          size: 35,
        ),
        title: ("Settings"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            // initialRoute: '/',
            // routes: {
            //   '/first': (context) => LoginPage(),
            //   '/second': (context) => RegisterScreen(),
            // },
            ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      // appBar: AppBar(title: const Text('Navigation Bar Demo')),
      // drawer: Drawer(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Text('This is the Drawer'),
      //       ],
      //     ),
      //   ),
      // ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.grey[300],
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: 90,
        // MediaQuery.of(context).viewInsets.bottom > 0
        //     ? 0.0
        //     : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context,
            useSafeArea: true,
            builder: (context) => Container(
              height: 50.0,
              width: 50.0,
              color: Colors.white,
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        selectedTabScreenContext: (context) {
          // testContext = context;
        },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.amber,
            borderRadius: BorderRadius.circular(30.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style12, // Choose the nav bar style with this property
      ),
    );
  }
}
