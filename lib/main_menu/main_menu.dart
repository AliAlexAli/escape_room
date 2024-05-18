import 'package:escape_room/direction_arrow/direction_arrow.dart';
import 'package:escape_room/direction_arrow/direction_arrow_bindings.dart';
import 'package:escape_room/notification/notification.dart' as Noti;
import 'package:escape_room/notification/notification_bindings.dart';
import 'package:escape_room/outline/outline.dart';
import 'package:escape_room/outline/outline_bindings.dart';
import 'package:escape_room/proximity/proximity.dart';
import 'package:escape_room/proximity/proximity_bindings.dart';
import 'package:escape_room/qr_reader/qr_reader.dart';
import 'package:escape_room/qr_reader/qr_reader_bindings.dart';
import 'package:escape_room/service/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  onChanged: (value) {
                    final x = double.tryParse(value);
                    if (x != null) {
                      Get.find<GeolocationService>().lan.value = x;
                    }
                  },
                ),
                TextFormField(
                  onChanged: (value) {
                    final x = double.tryParse(value);
                    if (x != null) {
                      Get.find<GeolocationService>().lon.value = x;
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const QrReader(), binding: QrReaderBindings()),
                  child: const Text('QR olvasó'),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const DirectionArrow(), binding: DirectionArrowBindings()),
                  child: const Text('Nyíl'),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const Proximity(), binding: ProximityBindings()),
                  child: const Text('Villogás'),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const Outline(), binding: OutlineBindings()),
                  child: const Text('Körvonal'),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(() => const Noti.Notification(), binding: NotificationBindings()),
                  child: const Text('Értesítés'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
