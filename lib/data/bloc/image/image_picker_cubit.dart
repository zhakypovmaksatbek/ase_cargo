import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerCubit extends Cubit<FeedbackImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerCubit() : super(FeedbackImagePickerState());
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
    emit(state.copyWith(
        pickedFile: state.pickedFile, pickedFiles: state.pickedFiles));
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

  Future<void> permissionGalleryForReview() async {
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
      await permissionGallery();
    }
  }
}

class FeedbackImagePickerState {
  XFile? pickedFile;
  List<XFile>? pickedFiles;

  FeedbackImagePickerState({this.pickedFile, this.pickedFiles});

  FeedbackImagePickerState copyWith(
      {XFile? pickedFile, List<XFile>? pickedFiles}) {
    return FeedbackImagePickerState(
      pickedFile: pickedFile ?? this.pickedFile,
      pickedFiles: pickedFiles ?? this.pickedFiles,
    );
  }
}
