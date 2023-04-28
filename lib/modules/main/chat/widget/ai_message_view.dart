import 'package:Freud_AI_app/shared/constants/color_constants.dart';
import 'package:Freud_AI_app/shared/constants/png_image_constant.dart';
import 'package:Freud_AI_app/shared/utils/math_utils.dart';
import 'package:Freud_AI_app/shared/widgets/base_text.dart';

import 'package:flutter/material.dart';

class AiMessageView extends StatelessWidget {
  const AiMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - getSize(80)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(PngImageConstants.aiProfile),
              radius: getSize(18),
            ),
            SizedBox(
              width: getSize(10),
            ),
            Expanded(
              child: BaseText(
                text:
                    "Hello, how can i help you?",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: ColorConstants.white,
                maxLines: 50,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
