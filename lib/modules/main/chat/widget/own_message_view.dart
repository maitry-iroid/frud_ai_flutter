import 'package:Freud_AI_app/shared/constants/color_constants.dart';
import 'package:Freud_AI_app/shared/constants/png_image_constant.dart';
import 'package:Freud_AI_app/shared/utils/math_utils.dart';
import 'package:Freud_AI_app/shared/widgets/base_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnMessageView extends StatelessWidget {
  const OwnMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - getSize(80)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child:
              BaseText(
                text:
                    "I need information regarding yoga.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: ColorConstants.white,
                textAlign: TextAlign.end,
                maxLines: 50,
              ),
            ),
            SizedBox(
              width: getSize(10),
            ),
            CircleAvatar(
              backgroundImage: AssetImage(PngImageConstants.ownProfile),
              radius: getSize(18),
            )
          ],
        ),
      ),
    );
  }
}

//constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width - getSize(60)),
