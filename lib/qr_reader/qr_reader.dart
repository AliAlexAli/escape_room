import 'package:escape_room/qr_reader/qr_reader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReader extends GetView<QrReaderController> {
  const QrReader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Obx(
          () {
            if (controller.permission.value != PermissionStatus.granted) {
              return const Center(
                  child: Text(
                'Engedélyezze az alkalmazásnak a kamera használatát!',
                textAlign: TextAlign.center,
              ));
            }
            return QRView(
              overlay: QrScannerOverlayShape(),
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
            );
          },
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        IconButton(onPressed: () => controller.qrController?.toggleFlash(), icon: const Icon(Icons.flashlight_on)),
        IconButton(onPressed: () => controller.qrController?.flipCamera(), icon: const Icon(Icons.flip_camera_ios)),
        Obx(() => controller.isPaused.value
            ? IconButton(
                onPressed: () async {
                  await controller.qrController?.resumeCamera();
                  controller.isPaused.value = false;
                },
                icon: const Icon(Icons.play_arrow),
              )
            : IconButton(
                onPressed: () async {
                  await controller.qrController?.pauseCamera();
                  controller.isPaused.value = true;
                },
                icon: const Icon(Icons.pause),
              ))
      ],
    );
  }
}
