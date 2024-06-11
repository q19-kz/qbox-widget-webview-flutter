
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';


Future<PermissionResponse?> handlePermission(controller, request) async {
  final resources = <PermissionResourceType>[];
  if (request.resources.contains(PermissionResourceType.CAMERA)) {
    final cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isDenied) {
      resources.add(PermissionResourceType.CAMERA);
    }
  }
  if (request.resources.contains(PermissionResourceType.MICROPHONE)) {
    final microphoneStatus = await Permission.microphone.request();
    if (!microphoneStatus.isDenied) {
      resources.add(PermissionResourceType.MICROPHONE);
    }
  }
  // only for iOS and macOS
  if (request.resources
      .contains(PermissionResourceType.CAMERA_AND_MICROPHONE)) {
    final cameraStatus = await Permission.camera.request();
    final microphoneStatus = await Permission.microphone.request();
    if (!cameraStatus.isDenied && !microphoneStatus.isDenied) {
      resources.add(PermissionResourceType.CAMERA_AND_MICROPHONE);
    }
  }

  return PermissionResponse(
      resources: resources,
      action: resources.isEmpty
          ? PermissionResponseAction.DENY
          : PermissionResponseAction.GRANT
  );
}
