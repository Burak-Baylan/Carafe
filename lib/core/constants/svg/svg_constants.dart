import '../../extensions/string_extensions.dart';

class SVGConstants {
  static SVGConstants? _instance;
  static SVGConstants get instance =>
      _instance = _instance == null ? SVGConstants._init() : _instance!;
  SVGConstants._init();

  String get login => "login".toSvg;
  String get signup => "signup".toSvg;
}