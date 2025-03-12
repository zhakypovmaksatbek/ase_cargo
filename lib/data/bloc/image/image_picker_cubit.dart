import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/dialogs/app_dialogs.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerCubit extends Cubit<FeedbackImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerCubit() : super(FeedbackImagePickerState());

  Future<void> pickFrontImage(BuildContext context) async {
    // Galeri izni kontrolü
    final bool isGranted = await galleryPermission();
    if (isGranted) {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      emit(state.copyWith(frontFile: pickedFile));
    } else {
      if (context.mounted) {
        bool? goSettings = await AppDialogs.defaultDialog(
            context,
            AppText(title: "title", textType: TextType.body),
            ColorConstants.primary);
        if (goSettings ?? false) {
          await AppSettings.openAppSettings(type: AppSettingsType.settings);
        }
      }
    }
  }

  // Kimlik fotoğrafı (arka yüz) seçme
  Future<XFile?> pickBackImage(BuildContext context) async {
    // Galeri izni kontrolü
    final bool isGranted = await galleryPermission();
    if (isGranted) {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      emit(state.copyWith(backFile: pickedFile));
      return pickedFile;
    } else {
      if (context.mounted) {
        bool? goSettings = await AppDialogs.defaultDialog(
            context,
            AppText(title: "title", textType: TextType.body),
            ColorConstants.primary);
        if (goSettings ?? false) {
          await AppSettings.openAppSettings(type: AppSettingsType.settings);
        }
      }
      return null;
    }
  }

  void removePickImage(ImageType type) {
    switch (type) {
      case ImageType.frontFile:
        state.frontFile = null;
        emit(state.copyWith(frontFile: state.frontFile));
        break;
      case ImageType.backFile:
        state.backFile = null;
        emit(state.copyWith(backFile: state.backFile));
        break;
      case ImageType.recipientFrontFile:
        state.recipientFrontFile = null;
        emit(state.copyWith(recipientFrontFile: state.recipientFrontFile));
        break;
      case ImageType.recipientBackFile:
        state.recipientBackFile = null;
        emit(state.copyWith(recipientBackFile: state.recipientBackFile));
        break;
      case ImageType.signature:
        state.pickedFile = null;
        emit(state.copyWith(pickedFile: state.pickedFile));
        break;
    }
  }

  Future<void> checkImageFromGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    emit(state.copyWith(pickedFile: pickedFile));
  }

  Future<void> checkMultiImageFromGallery() async {
    final pickedFiles = await _picker.pickMultiImage(
      imageQuality: 50,
    );
    emit(state.copyWith(pickedFiles: pickedFiles));
  }

  void removeFromImageList({required String path}) {
    state.pickedFiles!.removeWhere((image) => image.path == path);
    emit(state.copyWith(pickedFiles: state.pickedFiles));
  }

  void removeImage() {
    state.pickedFile = null;
    emit(state.copyWith(pickedFile: state.pickedFile));
  }

  void cleanData() {
    state.pickedFile = null;
    state.pickedFiles = null;
    state.frontFile = null;
    state.backFile = null;
    state.recipientBackFile = null;
    state.recipientFrontFile = null;
    emit(state.copyWith(
        pickedFile: state.pickedFile,
        pickedFiles: state.pickedFiles,
        frontFile: state.frontFile,
        backFile: state.backFile,
        recipientBackFile: state.recipientBackFile,
        recipientFrontFile: state.recipientFrontFile));
  }

  Future<void> checkImageFromCamera(context) async {
    final pickedFile = await _picker.pickImage(
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 50,
      source: ImageSource.camera,
    );
    emit(state.copyWith(pickedFile: pickedFile));
  }

  Future<void> permissionCamera(context) async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      await checkImageFromCamera(context);
    } else {
      PermissionStatus result = await Permission.camera.request();
      if (result.isGranted) {
        await checkImageFromCamera(context);
        return;
      } else {
        await AppSettings.openAppSettings(type: AppSettingsType.settings);
        return;
      }
    }
  }

  Future<void> permissionIOSGallery() async {
    final status = await Permission.photos.status;
    if (status.isGranted) {
      await checkImageFromGallery();
    } else {
      final result = await Permission.photos.request();
      if (result.isGranted) {
        await checkImageFromGallery();
        return;
      } else {
        await AppSettings.openAppSettings(type: AppSettingsType.settings);
        return;
      }
    }
  }

  Future<void> permissionIOSGalleryForReview() async {
    final status = await Permission.photos.status;

    if (status.isGranted || status.isLimited) {
      await checkMultiImageFromGallery();
    } else {
      final result = await Permission.photos.request();
      if (result.isGranted || result.isLimited) {
        await checkMultiImageFromGallery();
      } else {
        await AppSettings.openAppSettings(type: AppSettingsType.settings);
      }
    }
  }

  Future<void> permissionGallery() async {
    final status = await Permission.photos.status;
    if (status.isGranted) {
      await checkImageFromGallery();
    } else {
      final result = await Permission.photos.request();
      if (result.isGranted) {
        await checkImageFromGallery();
        return;
      } else {
        await AppSettings.openAppSettings(type: AppSettingsType.settings);
        return;
      }
    }
  }

  Future<bool> galleryPermission() async {
    final status = await Permission.photos.status;
    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.photos.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> permissionGalleryForMultiImage() async {
    final status = await Permission.mediaLibrary.status;
    if (status.isGranted) {
      await checkMultiImageFromGallery();
    } else {
      final result = await Permission.mediaLibrary.request();
      if (result.isGranted) {
        await checkMultiImageFromGallery();
        return;
      } else {
        await AppSettings.openAppSettings(type: AppSettingsType.settings);
        return;
      }
    }
  }

  Future<void> checkPlatformPermission() async {
    if (Platform.isIOS) {
      await permissionIOSGallery();
    } else {
      await checkImageFromGallery();
    }
  }

  void updateImage(ImageType type, XFile file) {
    switch (type) {
      case ImageType.frontFile:
        emit(state.copyWith(frontFile: file));
        break;
      case ImageType.backFile:
        emit(state.copyWith(backFile: file));
        break;
      case ImageType.recipientFrontFile:
        emit(state.copyWith(recipientFrontFile: file));
        break;
      case ImageType.recipientBackFile:
        emit(state.copyWith(recipientBackFile: file));
        break;
      case ImageType.signature:
        emit(state.copyWith(pickedFile: file));
        break;
    }
  }

  Future<XFile?> pickImage(BuildContext context, ImageType type) async {
    final bool isGranted = await galleryPermission();
    if (isGranted) {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        updateImage(type, pickedFile);
      }
      return pickedFile;
    } else {
      if (context.mounted) {
        bool? goSettings = await AppDialogs.defaultDialog(
            context,
            AppText(title: "title", textType: TextType.body),
            ColorConstants.primary);
        if (goSettings ?? false) {
          await AppSettings.openAppSettings(type: AppSettingsType.settings);
        }
      }
      return null;
    }
  }
}

class FeedbackImagePickerState {
  XFile? pickedFile;
  XFile? frontFile;
  XFile? backFile;
  XFile? recipientFrontFile;
  XFile? recipientBackFile;
  List<XFile>? pickedFiles;

  FeedbackImagePickerState(
      {this.pickedFile,
      this.pickedFiles,
      this.frontFile,
      this.backFile,
      this.recipientBackFile,
      this.recipientFrontFile});

  FeedbackImagePickerState copyWith(
      {XFile? pickedFile,
      List<XFile>? pickedFiles,
      XFile? frontFile,
      XFile? backFile,
      XFile? recipientBackFile,
      XFile? recipientFrontFile}) {
    return FeedbackImagePickerState(
        pickedFile: pickedFile ?? this.pickedFile,
        pickedFiles: pickedFiles ?? this.pickedFiles,
        frontFile: frontFile ?? this.frontFile,
        backFile: backFile ?? this.backFile,
        recipientBackFile: recipientBackFile ?? this.recipientBackFile,
        recipientFrontFile: recipientFrontFile ?? this.recipientFrontFile);
  }
}

enum ImageType {
  frontFile,
  backFile,
  recipientFrontFile,
  recipientBackFile,
  signature,
}
