import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage.dart';

class ThemeUtils {
  static final prefs = Get.find<SharedPreferences>();
  static final currentTheme = prefs.getString(StorageConstants.profileType).obs;
}
