import 'package:escape_room/outline/outline_controller.dart';
import 'package:get/get.dart';

class OutlineBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(OutlineController());
  }
}
