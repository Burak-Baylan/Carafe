import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class NetworkToFile{
  static Future<File> convert(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, url.substring(url.length - url.length ~/ 2)));
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }
}