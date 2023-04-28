import 'package:Freud_AI_app/api/api_repository.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final ApiRepository repository;
  final formKey = GlobalKey<FormState>();

  AuthController({required this.repository});
}
