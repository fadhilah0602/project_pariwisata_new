import 'package:flutter/material.dart';

import 'home_page.dart';

class NavigationPage extends StatefulWidget {
  // const NavigationPage({super.key});
  final int initialIndex;

  const NavigationPage({super.key, this.initialIndex = 0});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with SingleTickerProviderStateMixin {

  late TabController tabController;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialIndex);
    pageController = PageController(initialPage: widget.initialIndex);

    //sinkronisasi
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        pageController.jumpToPage(tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: tabController, children: [
        PageMulai(pageController: pageController),
      ]),
    );
  }
}
