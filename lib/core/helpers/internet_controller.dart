import 'dart:io';

class InternetController {
  static InternetController get instance => InternetController._init();
  InternetController._init();

  static Future<bool> get check async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
