import '../constants/global_constants/constants.dart';

extension StringExtension on String {
  String get toSvg => "assets/svg/$this.svg";
  bool get isEmailValid => RegExp(GlobalConstants.EMAIL_REGEX).hasMatch(this);
  String? get emailValidator {
    var text = this;
    if (text == null || text.isEmpty) return "Email cannot be empty";
    if (!text.trim().isEmailValid) return "Email not valid";
    return null;
  }

  String? get passwordValidator {
    var text = this;
    if (text == null || text.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  bool get isUsernameValid => RegExp(GlobalConstants.USERNAME_REGEX).hasMatch(this);
}
