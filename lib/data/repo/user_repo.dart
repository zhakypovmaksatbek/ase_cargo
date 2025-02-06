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
  }

  @override
  Future<RegisterResponceModel> register(RegisterModel model) async {
    final response = await dio.post(
      "v1/auth/register/",
      model.toJson(),
    );
    return RegisterResponceModel.fromJson(response.data);
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
  Future<RegisterResponceModel> resentCode(String phone) async {
    final response = await dio.post(
      "v1/auth/verification/otp/send/",
      {"phone": phone},
    );
    return RegisterResponceModel.fromJson(response.data);
  }
}

abstract class IUserRepo {
  Future<RegisterResponceModel> register(RegisterModel model);
  Future<void> login(LoginModel model);
  Future<VerifyModel> verify(VerifyModel model);
  Future<RegisterResponceModel> resentCode(String phone);
}
