import 'package:Carafe/core/permissions/permissions_base.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermission extends IPermissions {
  static CameraPermission? _instance;
  static CameraPermission get instance => CameraPermission._init();
  CameraPermission._init();

  @override
  Future<bool> request() async {
    if (await camera.isGranted) return true;
    var response = await camera.request();
    if (response.isGranted) return true;
    return false;
  }
}
