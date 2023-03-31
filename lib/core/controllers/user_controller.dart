import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:popsy_second_app/core/repositories/user_repo.dart';

import '../data/response/api_response.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  UserRepo userReop;
  UserController({required this.userReop});

  ResponseModel? responseModel;

  // UserModel? _userModel;
  // UserModel? get userModel => _userModel;

  List<UserData>? _userData;
  List<UserData>? get userData => _userData;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _noMoreData = false;
  bool get noMoreData => _noMoreData;

  Future<void> login(String page) async {
    _isLoading;
    ApiResponse apiResponse = await userReop.login(page);
    // log(json.encode(apiResponse.response?.statusCode ?? 'saraasd'));
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(apiResponse.response!.data);
      _userData = int.parse(page) == 1
          ? userModel.data!
          : [
              ...?_userData,
              ...userModel.data!,
            ];
      if (userModel.data!.isEmpty && int.parse(page) > 1) {
        _noMoreData = true;
      }
      _isLoading = false;
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      }
      responseModel = ResponseModel(false, errorMessage ?? '',
          data: apiResponse.response?.data);
      _isLoading = false;
    }

    update();
  }
}
