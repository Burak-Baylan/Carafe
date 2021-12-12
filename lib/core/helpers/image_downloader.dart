import 'dart:typed_data';

import 'package:Carafe/core/extensions/timestamp_extensions.dart';
import 'package:Carafe/core/permissions/storage_permission.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageDownloader {
  static Future download(
    String url, {
    String errorMessage = "Image couldn't downloaded",
    String successMessage = "Image downloaded",
  }) async {
    if (!(await StoragePermission.instance.request())) return;
    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 80,
      name: Timestamp.now().date,
    );
    Fluttertoast.showToast(msg: "Image downloaded.");
  }
}
