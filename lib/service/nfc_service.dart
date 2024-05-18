import 'dart:async';
import 'dart:math';

import 'package:escape_room/service/notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../color/color.dart';

class NfcService extends GetxService {

  @override
  void onInit() async {
    super.onInit();
    _startNfcSession();
  }

  @override
  void onClose() {
    NfcManager.instance.stopSession();
    super.onClose();
  }

  void _startNfcSession() {
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        String id = _getNfcId(tag.data);
        switch(id){
          case 'CA:F9:28:3E':
            Get.to(() => const FullScreenColor(color: Colors.blue), preventDuplicates: false);
            return;
          case '6E:F9:28:3E':
            Get.to(() => const FullScreenColor(color: Colors.green), preventDuplicates: false);
            return;
          case 'CC:51:29:3E':
            Get.to(() => const FullScreenColor(color: Colors.yellow), preventDuplicates: false);
            return;
          case '3C:FC:28:3E':
            Get.to(() => const FullScreenColor(color: Colors.red), preventDuplicates: false);
            return;
          case '18:D7:29:3E':
            Get.to(() => const FullScreenColor(color: Colors.orange), preventDuplicates: false);
            return;
        }
      },
    );
  }

  String _getNfcId(Map<String, dynamic> data) {
    List<int> identifier = [];

    if (data.containsKey("mifareclassic") && data["mifareclassic"].containsKey("identifier")) {
      identifier.addAll(List<int>.from(data["mifareclassic"]["identifier"]));
    }

    String hexString = identifier.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':');

    return hexString.toUpperCase();
  }
}
