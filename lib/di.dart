import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/services/storage_service.dart';

class DenpendencyInjection {
  static final prefs = Get.find<SharedPreferences>();
  static var isBusinessMode = false.obs;
  static var showLoader = true.obs;
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    // if (prefs.getString(StorageConstants.profileType) == null) {
    //   await prefs.setString(
    //       StorageConstants.profileType, StringConstant.casual);
    // }

    /// getUserData();

    ///  getTheme();
  }

  // static var userResponse = UserResponse().obs;

  // static getUserData() {
  //   if (prefs.getString(StorageConstants.userData) != null) {
  //     userResponse.value = UserResponse.fromJson(
  //       jsonDecode(
  //         prefs.getString(StorageConstants.userData)!,
  //       ),
  //     );

  //     print("UserData : ${userResponse.toJson()}");
  //   }
  // }
}
