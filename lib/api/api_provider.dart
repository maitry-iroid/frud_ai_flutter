// ignore_for_file: argument_type_not_assignable_to_error_handler, invalid_return_type_for_catch_error

import 'dart:io';

import 'package:Freud_AI_app/api/api_constants.dart';
import 'package:Freud_AI_app/api/interceptors/dio_connectivity_request_retrier.dart';
import 'package:Freud_AI_app/api/interceptors/retry_interceptor.dart';
import 'package:Freud_AI_app/models/response/common_response.dart';
import 'package:Freud_AI_app/shared/utils/common_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../shared/constants/constants.dart';

class ApiProvider {
  CommonResponse commonResponse = CommonResponse();
  var dio = Dio();
  //final NetworkManager networkManager = Get.put(NetworkManager());
  Future<CommonResponse> postMethod(String path, dynamic data,
      {bool isMultipart = false, FormData? formData}) async {
    dio = initDio(path, isMultipart: isMultipart);
    print("API Request ======= $data");
    //("API Request :connectionType.value ======= ${connectionType.value}");

    //if (connectionType.value != 0) {
    Response response = await dio
        .post(path,
            data: isMultipart ? formData : data,
            options: Options(
              headers: {
                'accept': 'application/json',
                'Content-Type': 'application/json'
              },
            ))
        .catchError((DioError error) {
      print("==ERROR===${error.response}");
      // print("==ERROR${err.response}");
      commonResponse = CommonResponse.fromJson(error.response?.data);

      if (commonResponse.dioMessage != null) {
        CommonWidget.toast(commonResponse.dioMessage ?? '');
      } else {
        CommonWidget.toast(StringConstant.serverError);
      }
      return error;
    });
    print("RESPONSE ======= ${response.data}");

    if (response.data != null && response.statusCode == 200) {
      commonResponse = CommonResponse.fromJson(response.data);
      EasyLoading.dismiss();
      if (commonResponse.dioMessage != null &&
          commonResponse.dioMessage != 'Card not found') {
        CommonWidget.toast(commonResponse.dioMessage!);
      }
    } else {
      EasyLoading.dismiss();

      // CommonWidget.errorToast(StringConstant.serverError);
    }

    return commonResponse;
  }

  Future<CommonResponse> getMethod(String path,
      {Map<String, dynamic>? queryParameters}) async {
    dio = initDio(path);
    print('path ==> $path');
    print('queryParameters ==> $queryParameters');

    CommonResponse commonResponse = CommonResponse();

    //print('dio : ${dio}');

    //if (connectionType.value != 0) {
    var response = await dio
        .get(
      path,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
      ),
      queryParameters: queryParameters,
    )
        .catchError((DioError e) {
      print("==ERROR===${e.toString()}");
      return e;
    });
    // print("RESPONSE ======= ${response.data}");
    if (response.statusCode == 200 && response.data != null) {
      EasyLoading.dismiss();
      commonResponse = CommonResponse.fromJson(response.data);
      if (commonResponse.dioMessage != null &&
          commonResponse.dioMessage != 'Card not found') {
        CommonWidget.toast(commonResponse.dioMessage!);
      }
    } else {
      EasyLoading.dismiss();

      // CommonWidget.errorToast(
      //     commonResponse.dioMessage ?? StringConstant.serverError);
    }

    return commonResponse;
  }

  Future<CommonResponse> putMethod(String path,
      {Map<String, dynamic>? query,
      dynamic data,
      bool isMultipart = false,
      FormData? formData}) async {
    dio = initDio(path, isMultipart: isMultipart);

    print("API Request ======= $data");
    // Response response = await put(path, data);
    // if (connectionType.value != 0) {
    var response = await dio
        .put(
      path,
      data: isMultipart ? formData : data,
      options: Options(
        headers: {
          'accept': 'application/json',
        },
      ),
    )
        .catchError((e) {
      print("==ERROR===${e.toString()}");
      return e;
    });
    print("RESPONSE ======= ${response.data}");
    if (response.statusCode == 200 && response.data != null) {
      commonResponse = CommonResponse.fromJson(response.data);
      EasyLoading.dismiss();
      if (commonResponse.dioMessage != null &&
          commonResponse.dioMessage != 'Card not found') {
        CommonWidget.toast(commonResponse.dioMessage!);
      }
    } else {
      EasyLoading.dismiss();

      // CommonWidget.errorToast(
      //     commonResponse.dioMessage ?? StringConstant.serverError);
    }

    return commonResponse;
  }

  Future<CommonResponse> deleteMethod(String path,
      {Map<String, dynamic>? data}) async {
    dio = initDio(
      path,
    );
    print("API Request ======= $data");

    //if (connectionType.value != 0) {
    Response response = await dio
        .delete(
      path,
      options: Options(
        headers: {
          'accept': 'application/json',
        },
      ),
      queryParameters: data,
    )
        .catchError((error) {
      print(error);
      return error;
    });
    print("RESPONSE ======= ${response.data}");

    if (response.data != null && response.statusCode == 200) {
      commonResponse = CommonResponse.fromJson(response.data);
      EasyLoading.dismiss();
      if (commonResponse.dioMessage != null &&
          commonResponse.dioMessage != 'Card not found') {
        CommonWidget.toast(commonResponse.dioMessage!);
      }
    } else {
      EasyLoading.dismiss();

      CommonWidget.toast(StringConstant.serverError);
    }

    return commonResponse;
  }

  Dio initDio(String partUrl, {bool isMultipart = false}) {
    Map<String, dynamic>? headers = {};
    String acceptHeader;
    String contentTypeHeader;

    acceptHeader = 'application/json';
    contentTypeHeader =
        isMultipart ? 'multipart/form-data' : 'application/json';
    // final prefs = Get.find<SharedPreferences>();
    headers = {
      HttpHeaders.acceptHeader: acceptHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader,
      // HttpHeaders.authorizationHeader: token != null &&
      //         token.isNotEmpty &&
      //         !partUrl.toString().contains(ApiConstants.checkVersion)
      //     ? 'Bearer $token'
      //     : null
    };

    // debugPrint(Injector.prefs.getString(PrefKeys.token));
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: 20000),
      receiveTimeout: Duration(milliseconds: 30000),
      headers: headers,
    );
    dio.options = options;
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
    return dio;
  }
}
