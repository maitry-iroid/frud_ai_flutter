import 'package:Freud_AI_app/modules/main/main_controller.dart';

import 'package:get/instance_manager.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(
        apiRepository: Get.find(),
      ),
    );
  }
}
