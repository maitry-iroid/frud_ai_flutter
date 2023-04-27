import 'package:flutter/material.dart';

class ColorConstants {
  static Color lightScaffoldBackgroundColor = fromHex('#F9F9F9');
  static Color darkScaffoldBackgroundColor = fromHex('#2F2E2E');
  static Color secondaryAppColor = fromHex('#22DDA6');
  static Color secondaryDarkAppColor = Colors.white;
  static Color buttonShadowColor = Color(0xFF25E098);
  static Color shadowColor = Color(0xFFE9E9E9);
  static Color grey1 = Color(0xFFE0E0E0);
  static Color black1 = Color(0xFF888C8F);
  static Color black2 = Color(0xFF626262);
  static Color tipColor = fromHex('#B6B6B6');
  static Color lightGray = Color(0xFFF6F6F6);
  static Color darkGray = Color(0xFF9F9F9F);
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);
  static Color darkGreenColor = Color(0xff0A4040);
  static Color lightBlackColor = Color(0xff292929);
  static Color grayColor = Color(0xff7B7B7B);
  static Color dividerlor = Color(0xffE3E3E3);
  static Color grey = Color(0xFFF4F4F4);
  static Color kPrimary = Color(0xFF8BC75A);
  static Color kPrimaryBusiness = Color(0xff008B8B);

  static Color redErrorColor = Color(0xFFFF4D4D);
  static Color unSelectedIconColor = Color(0xFFB5B5B5);
  static Color grey2 = Color(0xFF5E5E5E);
  static Color boxShadow = Color(0xFF252525);
  static Color businessProfilePrimary = Color(0xFF008B8B);
  static Color red = Color(0xFFFF0000);
}

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

// Color fromHex(String hex) {
//   assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
//       'hex color must be #rrggbb or #rrggbbaa');

//   return Color(
//     int.parse(hex.substring(1), radix: 16) +
//         (hex.length == 7 ? 0xff000000 : 0x00000000),
//   );
// }
