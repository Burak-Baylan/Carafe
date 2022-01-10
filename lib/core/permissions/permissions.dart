import 'package:Carafe/core/permissions/camera_permissions.dart';
import 'package:Carafe/core/permissions/storage_permission.dart';

class Permissions {
  static Permissions? _instance;
  static Permissions get instance =>
      _instance = _instance == null ? Permissions._init() : _instance!;
  Permissions._init();
  Future<bool> storagePermission() async => await StoragePermission.instance.request();
  Future<bool> cameraPermission() async => await CameraPermission.instance.request();
}