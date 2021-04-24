import '../components/components.dart';

mixin CardSizeManager {
  double cardSize(SizingInformation sizingInformation) {
    double cardSize;
    switch (sizingInformation.deviceType) {
      case DeviceScreenType.MOBILE:
        cardSize = 400;
        break;
      case DeviceScreenType.TABLET:
        cardSize = 500;
        break;
      case DeviceScreenType.DESKTOP:
        cardSize = 700;
        break;
      default:
        cardSize = 700;
    }
    return cardSize;
  }
}
