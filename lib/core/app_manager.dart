import 'package:ase/presentation/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  AppManager._();
  static AppManager instance = AppManager._();

  Future<SharedPreferences> preferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> setToken({required String accessToken}) async {
    final prefs = await preferences();
    await prefs.setString(AppConstants.instance.accessToken, accessToken);
  }

  Future<String?> getToken() async {
    final prefs = await preferences();
    final token = prefs.getString(AppConstants.instance.accessToken);
    return token;
  }

  Future<void> setRefreshToken({required String refreshToken}) async {
    final prefs = await preferences();
    await prefs.setString(AppConstants.instance.refreshToken, refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await preferences();
    final token = prefs.getString(AppConstants.instance.refreshToken);
    return token;
  }

  Future<void> setTokenExpiry({required DateTime expiryTime}) async {
    final prefs = await preferences();
    await prefs.setInt(
        AppConstants.instance.tokenExpiry, expiryTime.millisecondsSinceEpoch);
  }

  Future<DateTime?> getTokenExpiry() async {
    final prefs = await preferences();
    final expiry = prefs.getInt(AppConstants.instance.tokenExpiry);
    return expiry != null ? DateTime.fromMillisecondsSinceEpoch(expiry) : null;
  }

  Future<void> setDeviceToken({required String deviceToken}) async {
    final prefs = await preferences();
    await prefs.setString(AppConstants.instance.deviceToken, deviceToken);
  }

  Future<String?> getDeviceToken() async {
    final prefs = await preferences();
    final token = prefs.getString(AppConstants.instance.deviceToken);
    return token;
  }

  Future<void> setLanguage({required String language}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.instance.language, language);
  }

  Future<String?> getSelectedLanguage() async {
    final prefs = await preferences();
    final language = prefs.getString(AppConstants.instance.language);
    return language;
  }

  Future<void> setNotificationPermission(bool value) async {
    final prefs = await preferences();
    await prefs.setBool(AppConstants.instance.notificationPermission, value);
  }

  Future<bool> getNotificationPermission() async {
    final prefs = await preferences();
    final value = prefs.getBool(AppConstants.instance.notificationPermission);
    return value ?? false;
  }

  Future<void> setIsLogin(bool isLogin) async {
    final prefs = await preferences();
    prefs.setBool(AppConstants.instance.isLogin, isLogin);
  }

  Future<bool> getIsLogin() async {
    final prefs = await preferences();
    final value = prefs.getBool(AppConstants.instance.isLogin);
    return value ?? false;
  }

  Future<void> saveToPreferences(ThemeMode mode) async {
    final prefs = await preferences();
    await prefs.setBool('isLightMode', mode == ThemeMode.light);
  }

  // save and get userId
  Future<void> setUserId({required int userId}) async {
    final prefs = await preferences();
    await prefs.setInt(AppConstants.instance.userId, userId);
  }

  Future<int?> getUserId() async {
    final prefs = await preferences();
    final userId = prefs.getInt(AppConstants.instance.userId);
    return userId;
  }

  Future<void> setUserRole({required String role}) async {
    final prefs = await preferences();
    await prefs.setString(AppConstants.instance.userRole, role);
  }

  Future<String?> getUserRole() async {
    final prefs = await preferences();
    final role = prefs.getString(AppConstants.instance.userRole);
    return role;
  }

  Future<void> setChatId({required int chatId}) async {
    final prefs = await preferences();
    await prefs.setInt(AppConstants.instance.chatId, chatId);
  }

  Future<int?> getChatId() async {
    final prefs = await preferences();
    final userId = prefs.getInt(AppConstants.instance.chatId);
    return userId;
  }

  Future<void> clearTokens() async {
    final prefs = await preferences();
    await prefs.remove(AppConstants.instance.accessToken);
    await prefs.remove(AppConstants.instance.refreshToken);
    await prefs.remove(AppConstants.instance.tokenExpiry);

    await setIsLogin(false);
  }

  Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return true;

    final now = DateTime.now();
    final isExpired = now.isAfter(expiry.subtract(const Duration(minutes: 20)));

    if (kDebugMode && isExpired) {
      print('⏰ Token süresi dolmuş veya dolmak üzere');
      print('⏰ Şu anki zaman: ${now.toIso8601String()}');
      print('⏰ Token süresi: ${expiry.toIso8601String()}');
      print('⏰ Kalan süre: ${expiry.difference(now).inSeconds} saniye');
    }

    return isExpired;
  }
}
