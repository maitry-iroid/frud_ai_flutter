import 'package:align_flutter_app/shared/constants/color_constants.dart';
import 'package:align_flutter_app/shared/utils/math_utils.dart';
import 'package:align_flutter_app/shared/widgets/base_text.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  const CommonOutlineButton({
    Key? key,
    required this.onPressed,
    this.width,
    this.height,
    required this.text,
    this.fontWeight,
    required this.fontSize,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? Get.width,
      height: height ?? 50,
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.all(
            SmoothRadius(
              cornerRadius: getSize(16),
              cornerSmoothing: 1,
            ),
          ),
        ),
        // shadows: [
        //   BoxShadow(
        //     offset: Offset(0, 10),
        //     blurRadius: 30,
        //     color: Color(0xff25E098).withOpacity(0.20),
        //   ),
        // ],
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          //padding: EdgeInsets.zero,
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          side: BorderSide(
            color: ColorConstants.kPrimary,
          ),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerRadius: getSize(16),
                cornerSmoothing: 1,
              ),
            ),
          ),
        ),
        child: FittedBox(
          child: BaseText(
            text: text,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: fontSize ?? 16,
            textColor: textColor ?? ColorConstants.kPrimary,
          ),
        ),
      ),
    );
  }
}
