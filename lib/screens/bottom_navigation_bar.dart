import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobtrackeremployee/constants/app_colors.dart';
import 'package:jobtrackeremployee/constants/app_dimens.dart';
import 'package:jobtrackeremployee/models/job_detail_model.dart';
import 'package:jobtrackeremployee/screens/account_screen.dart';
import 'package:jobtrackeremployee/screens/home_screen.dart';
import 'package:jobtrackeremployee/screens/job_finder.dart';
import 'package:jobtrackeremployee/widgets/custom_bottom_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

BuildContext? testContext;

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen>
    with TickerProviderStateMixin {
  PersistentTabController? _controller;
  bool? _hideNavBar;
  AppDimens? appDimens;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _tabController = new TabController(length: 3, vsync: this);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      //  widget.isHomeScreen! ? HomeScreen():ThankyouScreen(),
      HomeScreen(),
      JobFinder(),
      AccountScreen(),

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        contentPadding: 0,
        icon: Icon(FontAwesomeIcons.briefcase),
        inactiveIcon: Icon(FontAwesomeIcons.briefcase),
        title: "My Jobs",
        iconSize: appDimens!.textw24,

        activeColorPrimary: AppColors.backgroundColor,
        // activeColorPrimary: AppColors.appColor,
        activeColorSecondary: Colors.white,

        // opacity: 0,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: appDimens!.textw14),
      ),
      PersistentBottomNavBarItem(
        contentPadding: 0,
        icon: Icon(FontAwesomeIcons.searchengin),
        inactiveIcon: Icon(FontAwesomeIcons.search),
        title: "Job Finder",
        iconSize: appDimens!.textw24,

        activeColorPrimary: AppColors.appColor,
        // activeColorPrimary: AppColors.appColor,
        activeColorSecondary: Colors.white,
        // opacity: 0,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: appDimens!.textw14),
      ),
      PersistentBottomNavBarItem(
        contentPadding: 0,
        icon: Icon(FontAwesomeIcons.userCircle),
        inactiveIcon: Icon(FontAwesomeIcons.userCircle),
        title: "Account",
        iconSize: appDimens!.textw24,

        activeColorPrimary: AppColors.appColor,
        // activeColorPrimary: AppColors.appColor,
        activeColorSecondary: Colors.white,
        // opacity: 0,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: appDimens!.textw14),
      ),

    ];
  }

  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    appDimens = AppDimens(MediaQuery.of(context).size.width);
    return PersistentTabView(
      context,
      navBarHeight: appDimens!.navBarHeight,

      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.appColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

  int? _currentIndex = 0;
  Color _inactiveColor = Colors.grey;
  _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.black,
      selectedIndex: _currentIndex!,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('Users'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

 _reTab() {
    return Container(
      height: 90,
      color: Color(0xff4681c3),
      child: TabBar(

        labelStyle: TextStyle(fontSize: 20),
        onTap: (index)async {

            _currentIndex = index;
            // await providerData.setIndet(index);
        },
        controller: _tabController,
        indicator: BoxDecoration(color: Color(0xff151515).withOpacity(0.4)),
        tabs: [
          Tab(
            icon: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dashboard,
                    size: 28,
                  ),
                  SizedBox(width: 15),
                  Text("Dashboard")
                ],
              ),
            ),
          ),
          Tab(
            icon: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart_outlined,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text("Reports")
                ],
              ),
            ),
          ),
          Tab(
            icon: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wallet_travel_outlined,
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text("Jobs")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
