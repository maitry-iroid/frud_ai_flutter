import 'package:Freud_AI_app/modules/auth/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        repository: Get.find(),
      ),
    );
  }
}
