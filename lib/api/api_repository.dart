import 'package:dio/dio.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;
}
