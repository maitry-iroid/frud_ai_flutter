import 'package:Freud_AI_app/network/network_manger.dart';
import 'package:get/get.dart';

import 'api/api.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiProvider(), permanent: true);
    Get.put(ApiRepository(apiProvider: Get.find()), permanent: true);
    Get.put(NetworkManager(), permanent: true);
  }
}
