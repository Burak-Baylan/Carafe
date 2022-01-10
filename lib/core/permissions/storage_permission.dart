import 'package:Carafe/core/permissions/permissions_base.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermission extends IPermissions {
  static StoragePermission? _instance;
  static StoragePermission get instance => StoragePermission._init();
  StoragePermission._init();

  @override
  Future<bool> request() async {
    if (await storage.isGranted) return true;
    var response = await storage.request();
    if (response.isGranted) return true;
    return false;
  }
}
