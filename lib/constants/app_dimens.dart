import 'dart:io';

enum DeviceType {
  ANDROIDPHONE,
  ANDROID7INCHTABLET,
  ANDROID10INCHTABLET,
  IOSDEVICE,
  IOS9INCHTAB,
  IOS10INCHTAB,
  IOS13INCHTAB
}

class AppDimens {
  double textw8 = 8;
  double textw10 = 10;
  double textw12 = 12;
  double textw14 = 14;
  double textw16 = 16;
  double textw18 = 18;
  double textw20 = 20;
  double textw22 = 22;
  double textw24 = 24;
  double textw26 = 26;
  double textw28 = 28;
  double textw30 = 30;
  double textw40 = 40;
  double textw46 = 46;
  double textw50 = 50;

  double paddingw0 = 0;
  double paddingw5 = 5;
  double paddingw11 = 11;
  double paddingw7 = 7;
  double paddingw9 = 9;
  double paddingw10 = 10;
  double paddingw12 = 12;
  double paddingw15 = 15;
  double paddingw20 = 20;
  double paddingw25 = 25;
  double chatWidth = 250.0;

  //
  double top = 22;
  double right = 15;

  double smallImageAssetsSize = 40;
  double navBarHeight = 77;
  double verticalHeight = 46;
  double appBarHeight = 56;

  DeviceType deviceType = DeviceType.ANDROIDPHONE;
  AppDimens(double width) {
    /*
    
    320dp: a typical phone screen (240x320 ldpi, 320x480 mdpi, 480x800 hdpi, etc).
    480dp: a large phone screen ~5" (480x800 mdpi).
    600dp: a 7” tablet (600x1024 mdpi).
    720dp: a 10” tablet (720x1280 mdpi, 800x1280 mdpi, etc).
*/
    if (Platform.isAndroid) {
      if ((width >= 600 && width <= 700)) {
        deviceType = DeviceType.ANDROID7INCHTABLET;
        textw8 = 18;
        smallImageAssetsSize = 60;
        verticalHeight = 46;
        navBarHeight = 77;
        appBarHeight = 56;

        top = 15;

        paddingw5 = 5;
        paddingw0 = 5;
        chatWidth = 350.0;

        // paddingw10 = 18;
      } else if ((width > 700)) {
        deviceType = DeviceType.ANDROID10INCHTABLET;
        textw8 = 22;

        paddingw5 = 7;
        paddingw0 = 10;
        chatWidth = 450.0;

        // paddingw10 = 70;
      } else {
        deviceType = DeviceType.ANDROIDPHONE;

        textw8 = 8;
        smallImageAssetsSize = 40;
        verticalHeight = 46;
        navBarHeight = 77;
        appBarHeight = 56;
        paddingw5 = 5;

        chatWidth = 250.0;

        // paddingw10 = 10;
      }
    } else if (Platform.isIOS) {
      if ((width >= 600 && width <= 700)) {
        deviceType = DeviceType.IOS9INCHTAB;
        textw8 = 12;
        smallImageAssetsSize = 40;
        verticalHeight = 46;
        navBarHeight = 77;
        appBarHeight = 56;
        paddingw5 = 10;
      } else if ((width > 700)) {
        deviceType = DeviceType.IOS13INCHTAB;
        textw8 = 13;
        smallImageAssetsSize = 40;
        verticalHeight = 56;
        navBarHeight = 77;
        appBarHeight = 56;
        paddingw5 = 7;
      } else {
        deviceType = DeviceType.IOSDEVICE;
        textw8 = 8;
        smallImageAssetsSize = 40;
        verticalHeight = 46;
        navBarHeight = 56;
        appBarHeight = 56;
        paddingw5 = 5;
      }
      // deviceType = DeviceType.;

    }

    textw10 = textw8 + 2;
    textw12 = textw8 + 4;
    textw14 = textw8 + 6;
    textw16 = textw8 + 8;
    textw18 = textw8 + 10;
    textw20 = textw8 + 12;
    textw22 = textw8 + 14;
    textw24 = textw8 + 16;
    textw26 = textw8 + 18;
    textw28 = textw8 + 20;
    textw30 = textw8 + 22;
    textw40 = textw8 + 32;
    textw46 = textw8 + 38;
    textw50 = textw8 + 42;

    paddingw5 = paddingw5;
    paddingw10 = paddingw5 + 5;
    paddingw15 = paddingw5 + 10;
    paddingw12 = paddingw5 + 8;
    paddingw11 = paddingw5 + 6;
    paddingw7 = paddingw5 + 2;
    paddingw9 = paddingw5 + 4;
    paddingw20 = paddingw5 + 15;
    paddingw25 = paddingw5 + 20;
  }
}
