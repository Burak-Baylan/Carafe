import 'package:flutter/cupertino.dart';

extension EdgeInsetsExtensions on double{
  EdgeInsets get edgeIntesetsAll => EdgeInsets.all(this);
  EdgeInsets get edgeIntesetsOnlyTop => EdgeInsets.only(top: this);
  EdgeInsets get edgeIntesetsOnlyBottom => EdgeInsets.only(bottom: this);
  EdgeInsets get edgeIntesetsOnlyRight => EdgeInsets.only(right: this);
  EdgeInsets get edgeIntesetsOnlyLeft => EdgeInsets.only(left: this);
  EdgeInsets get edgeIntesetsTopRight => EdgeInsets.only(top: this, right: this);
}