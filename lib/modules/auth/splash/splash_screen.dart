import 'dart:async';

import 'package:Freud_AI_app/routes/app_pages.dart';
import 'package:Freud_AI_app/shared/constants/color_constants.dart';
import 'package:Freud_AI_app/shared/constants/string_constant.dart';
import 'package:Freud_AI_app/shared/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () => Get.offAllNamed(Routes.MAIN),
    );
    return Scaffold(
      backgroundColor: ColorConstants.primary,
      body: Center(
        child: BaseText(
          text: StringConstant.freudAI,
          fontSize: 47,
          fontWeight: FontWeight.w600,
          textColor: ColorConstants.white,
        ),
      ),
    );
  }
}
