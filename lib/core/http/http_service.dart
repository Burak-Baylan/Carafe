import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../app/constants/private_class.dart';

class HttpService {
  static HttpService get instance => HttpService._init();
  HttpService._init();

  Future<Response> post({
    required Map<String, Object> data,
    required String postUrl,
  }) async {
    var response = await http.post(
      Uri.parse(postUrl),
      body: jsonEncode(data),
      headers: headers,
    );
    return response;
  }

  var headers = {
    'content-type': 'application/json',
    'Authorization': PrivateClass.notificationKey,
  };
}
