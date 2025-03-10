import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/dialogs/app_dialogs.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageProvider extends ChangeNotifier {
  String _message = '';
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  String? _pendingMessageId;

  // Getters
  String get message => _message;
  XFile? get selectedImage => _selectedImage;
  bool get isUploading => _isUploading;
  String? get pendingMessageId => _pendingMessageId;

  void setUploading(bool isUploading, {String? messageId}) {
    _isUploading = isUploading;
    _pendingMessageId = messageId;
    notifyListeners();
  }

  // Mesaj metnini güncelleme
  void updateMessage(String message) {
    _message = message;
    notifyListeners();
  }

  // Seçilen resmi güncelleme
  void updateSelectedImage(XFile? image) {
    _selectedImage = image;
    notifyListeners();
  }

  // Mesaj ve resmi temizleme
  void clearMessage() {
    _message = '';
    _selectedImage = null;
    notifyListeners();
  }

  // Galeriden resim seçme
  Future<void> pickImageFromGallery(BuildContext context) async {
    final bool hasPermission = await _checkGalleryPermission(context);

    if (hasPermission) {
      try {
        final XFile? pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
        );

        if (pickedImage != null) {
          _selectedImage = pickedImage;
          notifyListeners();
        }
      } catch (e) {
        debugPrint('Resim seçme hatası: $e');
      }
    }
  }

  // Kameradan resim çekme
  Future<void> pickImageFromCamera(BuildContext context) async {
    final bool hasPermission = await _checkCameraPermission(context);

    if (hasPermission) {
      try {
        final XFile? pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 70,
        );

        if (pickedImage != null) {
          _selectedImage = pickedImage;
          notifyListeners();
        }
      } catch (e) {
        debugPrint('Kamera hatası: $e');
      }
    }
  }

  // Galeri izni kontrolü
  Future<bool> _checkGalleryPermission(BuildContext context) async {
    PermissionStatus status;

    if (Platform.isIOS) {
      status = await Permission.photos.status;
    } else {
      status = await Permission.storage.status;
    }

    if (status.isGranted) {
      return true;
    } else {
      PermissionStatus result;

      if (Platform.isIOS) {
        result = await Permission.photos.request();
      } else {
        result = await Permission.storage.request();
      }

      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        if (context.mounted) {
          final bool? goToSettings = await _showPermissionDialog(context);
          if (goToSettings == true) {
            await AppSettings.openAppSettings(type: AppSettingsType.settings);
          }
        }
        return false;
      } else {
        return false;
      }
    }
  }

  // Kamera izni kontrolü
  Future<bool> _checkCameraPermission(BuildContext context) async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.camera.request();

      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        if (context.mounted) {
          final bool? goToSettings = await _showPermissionDialog(context);
          if (goToSettings == true) {
            await AppSettings.openAppSettings(type: AppSettingsType.settings);
          }
        }
        return false;
      } else {
        return false;
      }
    }
  }

  // İzin diyaloğu gösterme
  Future<bool?> _showPermissionDialog(BuildContext context) async {
    return await AppDialogs.defaultDialog(
      context,
      AppText(
        title: "Uygulama izinleri gerekiyor",
        textType: TextType.body,
      ),
      ColorConstants.primary,
    );
  }

  // Seçilen resmi kaldırma
  void removeSelectedImage() {
    _selectedImage = null;
    notifyListeners();
  }

  // Mesaj gönderme durumunu kontrol etme
  bool canSendMessage() {
    return _message.isNotEmpty || _selectedImage != null;
  }
}
