import 'package:align_flutter_app/modules/auth/auth_controller.dart';
import 'package:align_flutter_app/shared/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BaseText(text: "text")),
    );
  }
}
