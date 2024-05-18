import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class OutlineController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Outline');
  final result = Rxn<String>();
  final isPaused = false.obs;
  final permission = Rxn<PermissionStatus>();
  QRViewController? qrController;

  @override
  void onInit() {
    super.onInit();
    _getCameraPermission();
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
  }

  Future<void> _getCameraPermission() async {
    permission.value = await Permission.camera.status;
    if (permission.value != PermissionStatus.granted) {
      permission.value = await Permission.camera.request();
    }
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}
