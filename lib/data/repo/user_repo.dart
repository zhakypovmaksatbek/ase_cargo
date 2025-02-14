import 'package:ase/core/app_manager.dart';
import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/login_model.dart';
import 'package:ase/data/models/register_model.dart';
import 'package:ase/data/models/token_model.dart';
import 'package:ase/data/models/verify_model.dart';

class UserRepo implements IUserRepo {
  final dio = DioSettings();
  @override
  Future<void> login(LoginModel model) async {
    final response = await dio.post(
      "v1/auth/token/",
      model.toJson(),
    );
    final token = TokenModel.fromJson(response.data);
    await AppManager.instance.setToken(accessToken: token.access ?? "");
    await AppManager.instance.setIsLogin(true);
  }

  @override
  Future<RegisterResponseModel> register(RegisterModel model) async {
    final response = await dio.post(
      "v1/auth/register/",
      model.toJson(),
    );
    return RegisterResponseModel.fromJson(response.data);
  }

  @override
  Future<VerifyModel> verify(VerifyModel model) async {
    final response = await dio.post(
      "v1/auth/verification/otp/confirm/",
      model.toJson(),
    );
    return VerifyModel.fromJson(response.data);
  }

  @override
  Future<RegisterResponseModel> resentCode(String phone) async {
    final response = await dio.post(
      "v1/auth/verification/otp/send/",
      {"phone": phone},
    );
    return RegisterResponseModel.fromJson(response.data);
  }
}

abstract class IUserRepo {
  Future<RegisterResponseModel> register(RegisterModel model);
  Future<void> login(LoginModel model);
  Future<VerifyModel> verify(VerifyModel model);
  Future<RegisterResponseModel> resentCode(String phone);
}
