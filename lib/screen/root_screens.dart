import 'package:flutter_iconly/flutter_iconly.dart';

import 'cart/cart_screen.dart';
import '/screen/homepage.dart';
import '/screen/profile_screen.dart';
import '/screen/search_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static const routeName = '/RootScreen';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List<Widget> navScreen =  [
    HomePage(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  late PageController controller;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: navScreen,
      ),
      bottomNavigationBar: NavigationBar(
        height: kBottomNavigationBarHeight,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: currentPage,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.bag2),
            icon: Icon(IconlyLight.bag2),
            label: 'Cart',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (value) {
          setState(() {
            currentPage = value;
            controller.jumpToPage(currentPage);
          });
        },
      ),
    );
  }
}
