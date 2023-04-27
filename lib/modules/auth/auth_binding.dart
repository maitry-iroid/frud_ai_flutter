import 'package:align_flutter_app/modules/auth/auth_controller.dart';
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
