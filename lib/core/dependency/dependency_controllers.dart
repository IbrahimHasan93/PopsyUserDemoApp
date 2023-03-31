import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:popsy_second_app/core/controllers/user_controller.dart';
import 'package:popsy_second_app/core/repositories/user_repo.dart';

import '../data/dio/dio_client.dart';
import '../data/remote/logging_interceptors.dart';
import '../data/response/config_model.dart';

class ControllersDependencies extends Bindings {
  @override
  dependencies() {
    Dio dio = Dio();

    Get.lazyPut(() => dio);

    Get.lazyPut(() => LoggingInterceptor());
    Get.lazyPut(
      () => DioClient(
        BaseUrls.baseAPi,
        Get.find<Dio>(),
        loggingInterceptor: Get.find(),
      ),
    );
    //Repo
    Get.lazyPut(() => UserRepo(dioClient: Get.find()));

    //Controler
    Get.lazyPut(() => UserController(userReop: Get.find()));

    //core
  }
}
