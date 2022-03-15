import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class BaseView<T extends StatefulWidget> extends State<T> {
  void afterBuild(FrameCallback callback) =>
      WidgetsBinding.instance!.addPostFrameCallback(callback);
}
