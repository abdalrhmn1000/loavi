import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/shared_bloc/shared_bloc.dart';
import 'package:loavi_project/frontend/screens/main_services.dart';
import 'package:loavi_project/frontend/screens/options_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> navBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_outlined),
      title: 'home'.tr(),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.menu),
      title: 'settings'.tr(),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> screenOptions = <Widget>[MainServices(), OptionsScreen()];
    return BlocListener<SharedBloc, SharedState>(
      listener: (context, state) {
        if(state is LanguageChanged){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> AppNavigationBar()), (route) => false);
        }
      },
      child: PersistentTabView(
        context,
        screens: screenOptions,
        controller: _controller,
        items: navBarItems,
        handleAndroidBackButtonPress: true,
        popAllScreensOnTapOfSelectedTab: false,
        decoration: const NavBarDecoration(boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(0, -3),
              blurRadius: 42)
        ]),
        padding: const NavBarPadding.symmetric(vertical: 15, horizontal: 0),
        navBarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.080,
        navBarStyle: NavBarStyle.style12,
      ),
    );
  }
}
