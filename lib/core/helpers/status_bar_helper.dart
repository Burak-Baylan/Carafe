import 'package:flutter/services.dart';

class StatusBarHelper {
  static open() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);

  static close() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}
