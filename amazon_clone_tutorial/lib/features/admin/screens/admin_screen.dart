import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/features/admin/screens/analytics_screen.dart';
import 'package:amazon_clone_tutorial/features/admin/screens/order_screen.dart';
import 'package:amazon_clone_tutorial/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBorderBarWidth = 5;
  List<Widget> pages = [
    const PostScreen(),
    const AnalyticsScreen(),
    const OrderScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/amazon_in.png',
                      width: 120,
                      height: 45,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Admin',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ])),
      ),
      body: pages[_page],
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
          // ANALYTICS
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
                  child: const Icon(Icons.analytics_outlined)),
              label: ''),
          // ORDERS
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
                  child: const Icon(Icons.all_inbox_outlined)),
              label: ''),
        ],
      ),
    );
  }
}
