import 'permission_consts.dart';

abstract class IPermissions extends PermissionConsts{
  Future<bool> request();
}