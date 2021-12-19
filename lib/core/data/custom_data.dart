import 'package:Carafe/core/error/custom_error.dart';

class CustomData<T>{

  CustomError? error;
  T? data;

  CustomData(this.data, this.error);
}