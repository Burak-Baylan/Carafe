import 'package:Carafe/core/constants/global_constants/constants.dart';

extension StringExtension on String{
  String get toSvg => "assets/svg/$this.svg";
  bool get isEmailValid => RegExp(GlobalConstants.EMAIL_REGEX).hasMatch(this);
}