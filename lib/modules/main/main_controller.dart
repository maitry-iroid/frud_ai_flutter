import 'package:align_flutter_app/api/api_repository.dart';
import 'package:align_flutter_app/shared/constants/string_constant.dart';
import 'package:align_flutter_app/shared/widgets/base_text.dart';

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
  String? profilePage;
  String? locationPage;
  String? notificationPage;
  String? searchPage;
  String? messagePage;
  void switchTab(int index) async {
    currentTabIndex.value = index;
    switch (index) {
      case 0:
        if (!pageList.contains(profilePage)) {
          pageList.add(profilePage!);
        }
        pageIndex.value = pageList.indexOf(profilePage);
        break;
      case 1:
        if (!pageList.contains(locationPage)) {
          pageList.add(locationPage!);
        }

        pageIndex.value = pageList.indexOf(locationPage);
        break;

      case 2:
        if (!pageList.contains(searchPage)) {
          pageList.add(searchPage!);
        }
        pageIndex.value = pageList.indexOf(searchPage);
        break;
      case 3:
        if (!pageList.contains(messagePage)) {
          pageList.add(messagePage!);
        }
        pageIndex.value = pageList.indexOf(messagePage);
        break;
      case 4:
        if (!pageList.contains(notificationPage)) {
          pageList.add(notificationPage!);
        }
        pageIndex.value = pageList.indexOf(notificationPage);
        break;
      default:
    }
  }

  Route? onGenerateRoute(RouteSettings settings, String tabItem) {
    if (tabItem == Routes.PROFILE) {
      return getPageRoute(
        settings,
        Scaffold(
            body: Center(
          child: BaseText(text: "text"),
        )),
        // binding: ProfileBinding(),
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
    profilePage = Routes.PROFILE;

    // locationPage = Routes.LOCATION;
    // searchPage = Routes.SEARCH;
    // messagePage = Routes.CHAT;
    // notificationPage = Routes.NOTIFICATION;
    pageList.add(profilePage!);
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
