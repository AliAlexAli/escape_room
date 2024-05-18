import 'package:escape_room/qr_reader/qr_reader_controller.dart';
import 'package:get/get.dart';

class QrReaderBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(QrReaderController());
  }
}
