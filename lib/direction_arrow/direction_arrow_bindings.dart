import 'package:escape_room/direction_arrow/direction_arrow_controller.dart';
import 'package:get/get.dart';

class DirectionArrowBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(DirectionArrowController());
  }
}
