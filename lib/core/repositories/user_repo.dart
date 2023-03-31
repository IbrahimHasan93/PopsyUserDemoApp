import 'package:popsy_second_app/core/data/dio/dio_client.dart';

import '../data/remote/api_error_handler.dart';
import '../data/response/api_response.dart';
import '../data/response/config_model.dart';

class UserRepo {
  DioClient dioClient;
  UserRepo({required this.dioClient});

  Future<ApiResponse> login(String page) async {
    try {
      final response = await dioClient.get(
        BaseUrls.users + page,
      );
      print('object $response');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('cateched  $e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
