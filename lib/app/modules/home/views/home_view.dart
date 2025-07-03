import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/app/data/app.config.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedTabBarView(
        controller: controller.tabController,
        children: [
          ...tabs.map((e) => e['page'] as Widget),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.gotoAddGift();
      //   },
      //   shape: const CircleBorder(),
      //   backgroundColor: Colors.white,
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.black,
      //     size: 32,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder(
        id: 'update-selected-tab',
        init: controller,
        builder: (_) {
          return AnimatedBottomNavigationBar.builder(
            backgroundColor: Colors.white,
            itemCount: tabs.length,
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    tabs[index]['icon'],
                    width: (index == 2 || index == 1) ? 26 : 22,
                    height: (index == 2 || index == 1) ? 26 : 22,
                    colorFilter: isActive
                        ? ColorFilter.mode(
                            Get.theme.primaryColor,
                            BlendMode.srcIn,
                          )
                        : const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // Text(tabs[index]['label'] as String),
                ],
              );
            },
            height: 64,
            activeIndex: controller.selectedTabIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            leftCornerRadius: 0,
            rightCornerRadius: 0,
            onTap: controller.changeTab,
          );
        },
      ),
    );
  }
}
