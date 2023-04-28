import 'package:Freud_AI_app/shared/constants/color_constants.dart';
import 'package:Freud_AI_app/shared/constants/string_constant.dart';
import 'package:Freud_AI_app/shared/constants/svg_image_constant.dart';
import 'package:Freud_AI_app/shared/utils/image_utils.dart';
import 'package:Freud_AI_app/shared/utils/math_utils.dart';
import 'package:Freud_AI_app/shared/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      bottomNavigationBar: Container(
        height: getSize(80),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -4),
                blurRadius: 24,
                color: Color.fromRGBO(0, 0, 0, 0.15),
              ),
            ],
            border: Border(
                top:
                    BorderSide(color: ColorConstants.black.withOpacity(0.9)))),
        child: ClipRRect(
          child: BottomNavigationBar(
            // onTap: (value) {
            //   controller.switchTab(value);
            // },

            backgroundColor: ColorConstants.bottomBarColor,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: ColorConstants.white,
            unselectedItemColor: ColorConstants.unselectColor,
            // paddingBottomCircle: getSize(14),
            currentIndex: controller.currentTabIndex.value,
            unselectedLabelStyle: TextStyle(
                fontSize: getSize(14),
                fontWeight: FontWeight.w400,
                fontFamily: 'SF-Pro'),
            selectedLabelStyle: TextStyle(
                fontSize: getSize(14),
                fontWeight: FontWeight.w500,
                fontFamily: 'SF-Pro'),

            // color: ColorConstants.unSelectedIconColor,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: getSize(6)),
                  child: SvgPicture.asset(
                    SvgImageConstant.notes,
                    height: getSize(18.41),
                    width: getSize(16.67),
                    colorFilter: ColorFilter.mode(
                        controller.currentTabIndex.value == 0
                            ? ColorConstants.white
                            : ColorConstants.unselectColor,
                        BlendMode.srcIn),
                  ),
                ),
                label: StringConstant.today,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: getSize(6)),
                  child: SvgPicture.asset(
                    SvgImageConstant.search,
                    height: getSize(18.41),
                    width: getSize(16.67),
                    colorFilter: ColorFilter.mode(
                        controller.currentTabIndex.value == 1
                            ? ColorConstants.white
                            : ColorConstants.unselectColor,
                        BlendMode.srcIn),
                  ),
                ),
                label: StringConstant.library,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: getSize(6)),
                  child: SvgPicture.asset(
                    SvgImageConstant.profile,
                    height: getSize(18.41),
                    width: getSize(16.67),
                    colorFilter: ColorFilter.mode(
                        controller.currentTabIndex.value == 2
                            ? ColorConstants.white
                            : ColorConstants.unselectColor,
                        BlendMode.srcIn),
                  ),
                ),
                label: StringConstant.user,
              ),
            ],
            // milliseconds: 400,
          ),
        ),
      ),
    );
  }
}
