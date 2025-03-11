import 'package:ase/core/app_manager.dart';
import 'package:ase/core/dio_settings.dart';
import 'package:ase/data/models/login_model.dart';
import 'package:ase/data/models/register_model.dart';
import 'package:ase/data/models/token_model.dart';
import 'package:ase/data/models/user_model.dart';
import 'package:ase/data/models/user_role_model.dart';
import 'package:ase/data/models/verify_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepo implements IUserRepo {
  final dio = DioSettings();
  @override
  Future<void> login(LoginModel model) async {
    final response = await dio.post(
      "v1/auth/token/",
      data: model.toJson(),
    );

    if (kDebugMode) {
      print('📱 Login yanıtı: ${response.data}');
    }

    final token = TokenModel.fromJson(response.data);

    // Access token kaydet
    await AppManager.instance.setToken(accessToken: token.access ?? "");

    // Refresh token kontrolü ve kaydetme
    if (token.refresh != null && token.refresh!.isNotEmpty) {
      await AppManager.instance.setRefreshToken(refreshToken: token.refresh!);

      if (kDebugMode) {
        print('📱 Refresh token kaydedildi: ${token.refresh}');

        // Doğrulama için hemen oku
        final savedRefreshToken = await AppManager.instance.getRefreshToken();
        print('📱 Kaydedilen refresh token okundu: $savedRefreshToken');
      }
    } else {
      if (kDebugMode) {
        print('⚠️ Refresh token bulunamadı veya boş!');
        print('⚠️ Token yanıtı: ${response.data}');
      }
    }

    // Token süresini hesapla ve kaydet
    final expiresIn = token.expiresIn ?? 36; // Varsayılan 1 saat
    final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));
    await AppManager.instance.setTokenExpiry(expiryTime: expiryTime);

    await AppManager.instance.setIsLogin(true);

    final userRole = _getUserRoleFromToken(token.access ?? "-");
    await AppManager.instance.setUserRole(role: userRole?.roles?.first ?? "");
    await AppManager.instance.setUserId(userId: userRole?.userId ?? 0);
  }

  UserRoleModel? _getUserRoleFromToken(String token) {
    try {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return UserRoleModel.fromJson(decodedToken);
    } catch (e) {
      if (kDebugMode) {
        print("Error decoding token: $e");
      }
      return null;
    }
  }

  @override
  Future<RegisterResponseModel> register(RegisterModel model) async {
    final response = await dio.post(
      "v1/auth/register/",
      data: model.toJson(),
    );
    return RegisterResponseModel.fromJson(response.data);
  }

  @override
  Future<VerifyModel> verify(VerifyModel model) async {
    final response = await dio.post(
      "v1/auth/verification/otp/confirm/",
      data: model.toJson(),
    );
    final token = TokenModel.fromJson(response.data);
    await AppManager.instance.setToken(accessToken: token.access ?? "");
    await AppManager.instance.setIsLogin(true);
    return VerifyModel.fromJson(response.data);
  }

  @override
  Future<RegisterResponseModel> resentCode(String phone) async {
    final response = await dio.post(
      "v1/auth/verification/otp/send/",
      data: {"phone": phone},
    );
    return RegisterResponseModel.fromJson(response.data);
  }

  @override
  Future<UserModel> getUser() async {
    final response = await dio.get('v1/accounts/me-info/');
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> updateProfile(UserModel user,
      {XFile? image, required UserModel originalUser}) async {
    final String url = "v1/accounts/me-info/";
    if (image != null) {
      FormData formData =
          await user.toFormData(image: image, originalUser: originalUser);
      await dio.patch(url, formData);
    } else {
      await dio.patch(
          url, user.toUpdatedJson(original: originalUser, user: user));
    }
  }

  @override
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    await dio.patch("v1/accounts/change-password/",
        {"old_password": oldPassword, "new_password": newPassword});
  }

  @override
  Future<void> recoverySendCode(String phoneNumber) async {
    await dio
        .post("v1/auth/verification/otp/send", data: {"phone": phoneNumber});
  }

  @override
  Future<void> logout() async {
    try {
      // final refreshToken = await AppManager.instance.getRefreshToken();
      // if (refreshToken != null && refreshToken.isNotEmpty) {
      //   // Sunucuda token'ı iptal et (API'niz destekliyorsa)
      //   await dio.post("v1/auth/logout/", {"refresh": refreshToken});
      // }
    } catch (e) {
      if (kDebugMode) {
        print("Logout hatası: $e");
      }
    } finally {
      await AppManager.instance.clearTokens();
      await AppManager.instance.setIsLogin(false);
    }
  }
}

abstract class IUserRepo {
  Future<RegisterResponseModel> register(RegisterModel model);
  Future<void> login(LoginModel model);
  Future<VerifyModel> verify(VerifyModel model);
  Future<RegisterResponseModel> resentCode(String phone);
  Future<UserModel> getUser();
  Future<void> updateProfile(UserModel user,
      {XFile? image, required UserModel originalUser});
  Future<void> updatePassword(String oldPassword, String newPassword);

  Future<void> recoverySendCode(String phoneNumber);
  Future<void> logout();
}
