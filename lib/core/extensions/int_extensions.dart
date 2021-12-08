import 'package:flutter/material.dart';

extension RadiusExtension on int {
  Radius get radiusCircular => Radius.circular(toDouble());

  BorderRadius get radiusAll => BorderRadius.all(radiusCircular);
  BorderRadius get radiusTopLeft => BorderRadius.only(topLeft: radiusCircular);
  BorderRadius get radiusTopRight =>
      BorderRadius.only(topRight: radiusCircular);
  BorderRadius get radiusBottomLeft =>
      BorderRadius.only(bottomLeft: radiusCircular);
  BorderRadius get radiusBottomRight =>
      BorderRadius.only(bottomRight: radiusCircular);
  BorderRadius get radiusTopLeftBottomLeft =>
      BorderRadius.only(topLeft: radiusCircular, bottomLeft: radiusCircular);
  BorderRadius get radiusTopLeftTopRight =>
      BorderRadius.only(topLeft: radiusCircular, topRight: radiusCircular);
  BorderRadius get radiusBottomLeftBottomRight => BorderRadius.only(
      bottomLeft: radiusCircular, bottomRight: radiusCircular);
  BorderRadius get radiusTopRightBottomRight =>
      BorderRadius.only(topRight: radiusCircular, bottomRight: radiusCircular);
  BorderRadius get radiusTopLeftBottomRight =>
      BorderRadius.only(topLeft: radiusCircular, bottomRight: radiusCircular);
  BorderRadius get radiusTopRightBottomLeft =>
      BorderRadius.only(topRight: radiusCircular, bottomLeft: radiusCircular);
}

extension SizedBoxExtension on int {
  SizedBox get sizedBoxOnlyHeight => SizedBox(height: toDouble());
  SizedBox get sizedBoxOnlyWidth => SizedBox(width: toDouble());
  SizedBox get sizedBox => SizedBox(width: toDouble(), height: toDouble());
}

extension DurationExtension on int {
  Duration get durationDay => Duration(days: this);
  Duration get durationHours => Duration(hours: this);
  Duration get durationMinutes => Duration(minutes: this);
  Duration get durationSeconds => Duration(seconds: this);
  Duration get durationMilliseconds => Duration(milliseconds: this);
  Duration get durationnMicroseconds => Duration(microseconds: this);
}
