import 'package:escape_room/proximity/proximity_controller.dart';
import 'package:get/get.dart';

class ProximityBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(ProximityController());
  }
}
