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
            gapWidth: 0,
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    isActive
                        ? tabs[index]['icon_selected']
                        : tabs[index]['icon'],
                    width: 26,
                    height: 26,
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
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    tabs[index]['label'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive ? Get.theme.primaryColor : Colors.grey,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              );
            },
            height: 64,
            activeIndex: controller.selectedTabIndex.value,
            onTap: controller.changeTab,
          );
        },
      ),
    );
  }
}
