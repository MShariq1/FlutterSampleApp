import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:pin/src/source/data_source/authentication_local_data_source.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/error/exceptions.dart';
import '../data_source/authentication_local_data_source.dart';

class ApiClient {
  final Dio dio;
  final IAuthenticationLocalDataSource authenticationLocalDataSource;

  const ApiClient(
      {required this.dio, required this.authenticationLocalDataSource});

  Future<dynamic> get(Uri uri) async {
    try {
      final response = await dio.getUri(uri,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              HttpHeaders.accessControlAllowOriginHeader: "*",
              HttpHeaders.authorizationHeader:
                  'Bearer ${authenticationLocalDataSource.getAccessToken()??""}',
            },
          //  extra: params,
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      throw ServerException(e);
    }
  }

  Future<dynamic> post(Uri uri,
      {Map<String, dynamic>? params, Map<String, dynamic>? body}) async {
    try {
      final response = await dio.postUri(
        uri,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            HttpHeaders.accessControlAllowOriginHeader: "*",
            HttpHeaders.authorizationHeader:
                'Bearer ${authenticationLocalDataSource.getAccessToken()??""}',
          },
          extra: params,
        ),
        data: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      throw ServerException(e);
    }
  }

  Future<dynamic> patch(Uri uri,
      {Map<dynamic, dynamic>? body, Map<String, dynamic>? params}) async {
    try {
      final response = await dio.patchUri(
        uri,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            HttpHeaders.accessControlAllowOriginHeader: "*",
            HttpHeaders.authorizationHeader:
                'Bearer ${authenticationLocalDataSource.getAccessToken()??""}',
          },
          extra: params,
        ),
        data: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      throw ServerException(e);
    }
  }

  Future<dynamic> delete(Uri uri,
      {Map<dynamic, dynamic>? body, Map<String, dynamic>? params}) async {
    try {
      final response = await dio.deleteUri(
        uri,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            HttpHeaders.accessControlAllowOriginHeader: "*",
            HttpHeaders.authorizationHeader:
                'Bearer ${authenticationLocalDataSource.getAccessToken()}',
          },
          extra: params,
        ),
        data: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      throw ServerException(e);
    }
  }

  Future<dynamic> put(Uri uri,
      {Map<dynamic, dynamic>? body, Map<String, dynamic>? params}) async {
    try {
      final response = await dio.putUri(
        uri,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            HttpHeaders.accessControlAllowOriginHeader: "*",
            HttpHeaders.authorizationHeader:
                'Bearer ${authenticationLocalDataSource.getAccessToken()}',
          },
          extra: params,
        ),
        data: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      throw ServerException(e);
    }
  }
}

PrettyDioLogger prettyLogger() => PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90);

// void interceptorWrapper() => InterceptorsWrapper(
//       //onRequest: (request, handler) {},
//       onError: (error, handler) async {
//         if (error.response?.statusCode == 403 ||
//             error.response?.statusCode == 401) {
//           await refreshToken();
//           _retry(error.requestOptions);
//         }
//         //return error.response;
//       },
//       //  onResponse: (response, handler) {},
//     );

// Future<String?> refreshToken() async {
//   final pref = await SharedPreferences.getInstance();
//   final refreshToken = pref.getString(AppKeys.refreshToken);
//   final response = await Dio().postUri(
//       Uri.http(ApiConstant.baseUrl, ApiConstant.refreshToken),
//       data: {"refresh_token": refreshToken});
//   if (response.statusCode == 200) {
//     //this.accessToken =
//     return response.data['access_token'];
//   }
//   return null;
// }
//
// Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//   final options = Options(
//     method: requestOptions.method,
//     headers: requestOptions.headers,
//   );
//   return Dio().request<dynamic>(requestOptions.path,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//       options: options);
// }
