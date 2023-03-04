import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/features/account/screens/account_screen.dart';
import 'package:amazon_clone_tutorial/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBorderBarWidth = 5;
  List<Widget> pages=[
    const HomeScreen(),
    const AccountScreen(),
    const Center(child:Text('Cart Page'))
  ];

  void updatePage(int page){
    setState(() {
      _page=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // Home
          BottomNavigationBarItem(
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 0
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: bottomBorderBarWidth))),
                  child: const Icon(
                    Icons.home_outlined,
                  )),
              label: ''),
          // Account
          BottomNavigationBarItem(
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 1
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: bottomBorderBarWidth))),
                  child: const Icon(
                    Icons.person_outline_outlined,
                  )),
              label: ''),
          // CART
          BottomNavigationBarItem(
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 2
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: bottomBorderBarWidth))),
                  child: Badge(
                    elevation: 0,
                    badgeContent: const Text('2'),
                    badgeColor: Colors.white,
                    child: const Icon(
                      Icons.shopping_cart,
                    ),
                  )),
              label: '')
        ],
      ),
    );
  }
}
