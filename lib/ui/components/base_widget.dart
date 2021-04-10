import 'package:flutter/material.dart';

import 'sizing_information.dart';

class BaseWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;
  const BaseWidget({required this.builder});

  DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
    double deviceWidth = 0;

    deviceWidth = mediaQuery.size.width;

    if (deviceWidth > 950) {
      return DeviceScreenType.DESKTOP;
    }

    if (deviceWidth > 600) {
      return DeviceScreenType.TABLET;
    }

    return DeviceScreenType.MOBILE;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, boxSizing) {
      var sizingInformation = SizingInformation(
        orientation: mediaQuery.orientation,
        deviceType: getDeviceType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
      );

      return builder(context, sizingInformation);
    });
  }
}
