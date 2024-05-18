import 'package:escape_room/notification/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
