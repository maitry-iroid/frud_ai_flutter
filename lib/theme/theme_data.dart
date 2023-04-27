import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
  }) {
    // print("primaryColor : ${Theme.of(Get.context!).primaryColor}");
    return ThemeData(
      fontFamily: 'Poppins',
      // brightness: brightness,

      //scaffoldBackgroundColor: ColorConstants.white,
      // primaryColor: !DenpendencyInjection.isBusinessMode.value
      //     ? Color(0xff8BC75A)
      //     : Color(0xff008B8B),
      // appBarTheme: AppBarTheme(
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent,
      //     statusBarIconBrightness: Brightness.dark,
      //     statusBarBrightness: Brightness.light,
      //   ),
      // ),
      // inputDecorationTheme: InputDecorationTheme(
      //   floatingLabelBehavior: FloatingLabelBehavior.auto,
      //   border: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.grey1),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   errorBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.redErrorColor),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   enabledBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.grey1),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   disabledBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.grey1),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   focusedErrorBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(12), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.redErrorColor),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       color: ColorConstants.shadowColor.withOpacity(0.25),
      //     ),
      //   ),
      //   focusedBorder: DecoratedInputBorder(
      //     child: OutlineInputBorder(
      //       borderRadius: SmoothBorderRadius.all(
      //         SmoothRadius(cornerRadius: getSize(14), cornerSmoothing: 1),
      //       ),
      //       borderSide: BorderSide(color: ColorConstants.kPrimary),
      //     ),
      //     shadow: BoxShadow(
      //       offset: Offset(15, 20),
      //       blurRadius: 45,
      //       color: ColorConstants.shadowColor.withOpacity(0.25),
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
