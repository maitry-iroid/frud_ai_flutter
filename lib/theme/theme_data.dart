import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/constants/color_constants.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
  }) {
    // print("primaryColor : ${Theme.of(Get.context!).primaryColor}");
    return ThemeData(
      fontFamily: 'Inter',
      brightness: brightness,
      scaffoldBackgroundColor: ColorConstants.white,
      primaryColor: ColorConstants.primary,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      // inputDecorationTheme: InputDecorationTheme(
      //   floatingLabelBehavior: FloatingLabelBehavior.auto,
      //   border: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(50), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.unableColor),
      //     ),

      //   ),
      //   errorBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(50), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.red),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       //  color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   enabledBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(50), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.unableColor),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       //color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   disabledBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(50), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.unableColor),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       //color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   focusedErrorBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(50), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.red),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       //color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   focusedBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(50), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.primary),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       // color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      // ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
      );
}
