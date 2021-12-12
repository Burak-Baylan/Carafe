import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImage {
  static PickImage? _instance;
  static PickImage get instance =>
      _instance = _instance == null ? PickImage._init() : _instance!;
  PickImage._init();

  final _imagePicker = ImagePicker();

  Future<File?> gallery() async => await _pick(ImageSource.gallery);

  Future<File?> camera() async => await _pick(ImageSource.camera);

  Future<File?> _pick(ImageSource source) async {
    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (image == null) return null;
    final imageFile = File(image.path);
    return imageFile;
  }
}
