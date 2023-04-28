import 'package:Freud_AI_app/api/api_repository.dart';
import 'package:Freud_AI_app/modules/main/chat/today_chat_binding.dart';
import 'package:Freud_AI_app/modules/main/chat/today_chat_view.dart';
import 'package:Freud_AI_app/shared/constants/string_constant.dart';
import 'package:Freud_AI_app/shared/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';

class MainController extends GetxController {
  final ApiRepository apiRepository;

  MainController({required this.apiRepository});
  final prefs = Get.find<SharedPreferences>();
  var currentTabIndex = 0.obs;
  var pageIndex = 0.obs;
  var pageList = <String>[].obs;

  DateTime? currentBackPressTime;
  String? todayPage;
  String? libraryPage;
  String? userPage;

  void switchTab(int index) async {
    currentTabIndex.value = index;
    switch (index) {
      case 0:
        if (!pageList.contains(todayPage)) {
          pageList.add(todayPage!);
        }
        pageIndex.value = pageList.indexOf(todayPage);
        break;
      case 1:
        if (!pageList.contains(libraryPage)) {
          pageList.add(libraryPage!);
        }

        pageIndex.value = pageList.indexOf(libraryPage);
        break;

      case 2:
        if (!pageList.contains(userPage)) {
          pageList.add(userPage!);
        }
        pageIndex.value = pageList.indexOf(userPage);
        break;

      default:
    }
  }

  Route? onGenerateRoute(RouteSettings settings, String tabItem) {
    if (tabItem == Routes.TODAY) {
      return getPageRoute(
        settings,
        const TodayChatView(),
        binding: TodayChatBinding(),
      );
    }
    // } else if (tabItem == Routes.LOCATION) {
    //   return getPageRoute(
    //     settings,
    //     LocationView(),
    //     binding: LocationBinding(),
    //   );
    // } else if (tabItem == Routes.SEARCH) {
    //   return getPageRoute(
    //     settings,
    //     SearchView(),
    //     binding: SearchBinding(),
    //   );
    // } else if (tabItem == Routes.CHAT) {
    //   return getPageRoute(
    //     settings,
    //     MessageView(),
    //     binding: MessageBinding(),
    //   );
    // } else if (tabItem == Routes.NOTIFICATION) {
    //   return getPageRoute(
    //     settings,
    //     NotificationView(),
    //     binding: NotificationBinding(),
    //   );
    // }
    return null;
  }

  GetPageRoute getPageRoute(RouteSettings routeSettings, Widget page,
      {Bindings? binding}) {
    return GetPageRoute(
      settings: routeSettings,
      page: () => page,
      binding: binding,
    );
  }

  @override
  void onInit() {
    todayPage = Routes.TODAY;

    // locationPage = Routes.LOCATION;
    // searchPage = Routes.SEARCH;
    // messagePage = Routes.CHAT;
    // notificationPage = Routes.NOTIFICATION;
    pageList.add(todayPage!);
    super.onInit();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      EasyLoading.showToast(StringConstant.pressthebackbuttontoexit);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
