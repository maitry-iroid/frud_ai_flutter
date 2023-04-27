import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_controller.dart';

class MainTab extends GetView<MainController> {
  const MainTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () {
          return controller.onWillPop();
        },
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: IndexedStack(
        index: controller.pageIndex.value,
        children: List<Widget>.generate(
          controller.pageList.length,
          (int index) {
            return Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return controller.onGenerateRoute(
                    settings, controller.pageList[index]);
              },
            );
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationDot(
      //   paddingBottomCircle: getSize(14),
      //   currentIndex: controller.currentTabIndex.value,
      //   activeColor: ColorConstants.kPrimary,
      //   color: ColorConstants.unSelectedIconColor,
      //   items: [
      //     BottomNavigationDotItem(
      //       icon: getAssetsSVGImg('tab_icon_profile'),
      //       onTap: () {
      //         controller.switchTab(0);
      //         // changePage("flutter");
      //       },
      //     ),
      //     BottomNavigationDotItem(
      //       icon: getAssetsSVGImg('tab_icon_location'),
      //       onTap: () {
      //         controller.switchTab(1);
      //       },
      //     ),
      //     BottomNavigationDotItem(
      //       icon: getAssetsSVGImg('tab_icon_search'),
      //       onTap: () {
      //         controller.switchTab(2);
      //       },
      //     ),
      //     BottomNavigationDotItem(
      //       icon: getAssetsSVGImg('tab_icon_chat'),
      //       onTap: () {
      //         controller.switchTab(3);
      //       },
      //     ),
      //     BottomNavigationDotItem(
      //       icon: getAssetsSVGImg('tab_icon_notification'),
      //       onTap: () {
      //         controller.switchTab(4);
      //       },
      //     ),
      //   ],
      //   milliseconds: 400,
      // ),
    );
  }
}
