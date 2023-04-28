import 'package:Freud_AI_app/modules/main/chat/today_chat_controller.dart';
import 'package:Freud_AI_app/modules/main/chat/widget/ai_message_view.dart';
import 'package:Freud_AI_app/modules/main/chat/widget/own_message_view.dart';
import 'package:Freud_AI_app/shared/constants/svg_image_constant.dart';
import 'package:Freud_AI_app/shared/shared.dart';
import 'package:Freud_AI_app/shared/utils/math_utils.dart';
import 'package:Freud_AI_app/shared/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TodayChatView extends GetView<TodayChatController> {
  const TodayChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.primary,
        appBar: BaseAppBar(
          title: StringConstant.appBarText,
          actions: [
            SvgPicture.asset(SvgImageConstant.like),
            SizedBox(
              width: getSize(25),
            ),
            SvgPicture.asset(SvgImageConstant.refresh),
            SizedBox(
              width: getSize(25),
            ),
            Padding(
              padding: EdgeInsets.only(right: getSize(25)),
              child: SvgPicture.asset(SvgImageConstant.notification),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          child: Column(
            children: [getChats(), getMessageTextField()],
          ),
        ));
  }

  Widget getChats() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: 2,
          reverse: true,
          itemBuilder: (context, int index) => Column(
                children: [AiMessageView(),SizedBox(height: getSize(20),), OwnMessageView(),SizedBox(height: getSize(20),)],
              )),
    );
  }

  getMessageTextField() {
    return Padding(
      padding: EdgeInsets.only(bottom: getSize(30)),
      child: InputTextField(
        controller: controller.messageController,
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: getSize(23)),
          child: SvgPicture.asset(SvgImageConstant.send),
        ),
        hintText: StringConstant.messageHint,
        maxLines: 50,
        maxLength: 1000,
      ),
    );
  }
}
