import 'package:flutter/widgets.dart';

class SizingInformation {
  final Orientation? orientation;
  final DeviceScreenType? deviceType;
  final Size? screenSize;
  final Size? localWidgetSize;

  SizingInformation({
    this.orientation,
    this.deviceType,
    this.screenSize,
    this.localWidgetSize,
  });
}

enum DeviceScreenType { MOBILE, TABLET, DESKTOP }
