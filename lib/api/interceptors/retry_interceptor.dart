import 'dart:io';

import 'package:Freud_AI_app/api/interceptors/dio_connectivity_request_retrier.dart';
import 'package:Freud_AI_app/di.dart';
import 'package:Freud_AI_app/models/response/common_response.dart';
import 'package:Freud_AI_app/shared/constants/storage.dart';
import 'package:Freud_AI_app/shared/constants/string_constant.dart';
import 'package:Freud_AI_app/shared/utils/common_widget.dart';
import 'package:dio/dio.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getx;
import 'package:shared_preferences/shared_preferences.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final prefs = getx.Get.find<SharedPreferences>();
    final token = prefs.getString(StorageConstants.token);
    print('pref token===> $token');
    // print('request.url===> ${request.url}');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    if (DenpendencyInjection.showLoader.value) {
      EasyLoading.show(status: 'loading...');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'Request: URL ${response.requestOptions.method.toUpperCase()}: ${response.requestOptions.uri}');
    print('Request: Headers ${response.headers}');
    print('Response: Status ${response.statusCode}');
    print('Response: Status ${response.statusMessage}');
    print('Response: Body ${response.data.toString()}');
    EasyLoading.dismiss();
    // if (response.statusCode == 200) {
    //   return;
    // }
    // if (response.statusCode == 200 && response.data != null) {
    //   EasyLoading.dismiss();
    //   var commonResponse = CommonResponse.fromJson(response.data);
    //   if (commonResponse.dioMessage != null &&
    //       commonResponse.dioMessage != 'Card not found') {
    //     CommonWidget.successToast(commonResponse.dioMessage!);
    //   }
    // }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    EasyLoading.dismiss();
    if (_shouldRetry(err)) {
      CommonWidget.toast(StringConstant.networkError);
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        print("==ERROR${err.response}");
      }
    } else if (err.response?.statusCode == 401) {
      if (DenpendencyInjection.prefs.getString(StorageConstants.token) !=
          null) {
        //DependencyInjection.logout();
      } else {
        await DenpendencyInjection.prefs.clear();
        await DenpendencyInjection.prefs
            .setBool(StorageConstants.userShowIntro, true);

        //getx.Get.offAllNamed(Routes.auth);
      }
    } else if (err.response?.statusCode != 200) {
      EasyLoading.dismiss();
      var commonResponse = CommonResponse.fromJson(err.response?.data);
      if (commonResponse.dioMessage != null &&
          commonResponse.dioMessage != 'Card not found') {
        EasyLoading.showToast(commonResponse.dioMessage ?? '');
        //CommonWidget.successToast(commonResponse.dioMessage!);
      }
    }

    super.onError(err, handler);
  }
  // @override
  // Future onError(DioError err) async {
  //   if (_shouldRetry(err)) {
  //     try {
  //       return requestRetrier.scheduleRequestRetry(err.request);
  //     } catch (e) {
  //       return e;
  //     }
  //   }
  //   return err;
  // }

  bool _shouldRetry(DioError err) {
    printInfo(info: '${err.error}');
    return err.error is SocketException;
  }
}
