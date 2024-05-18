import 'package:escape_room/service/geolocation_service.dart';
import 'package:escape_room/service/notification_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  final _geoService = Get.find<GeolocationService>();

  Future<void> showNotification() async {
    await _notificationService.showNotification('Távolság', '${_geoService.getDistance().toInt()} méter');
  }
}
