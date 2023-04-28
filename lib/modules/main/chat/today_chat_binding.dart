import 'package:Freud_AI_app/modules/main/chat/today_chat_controller.dart';
import 'package:get/get.dart';

class TodayChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayChatController>(
      () => TodayChatController(
        //apiRepository: Get.find(),
      ),
    );
  }
}
