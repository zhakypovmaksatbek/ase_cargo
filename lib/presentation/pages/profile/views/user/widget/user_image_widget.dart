// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    super.key,
    required this.imageUrl,
    required this.formCubit,
  });
  final String imageUrl;
  final ImagePickerCubit formCubit;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 65,
          backgroundColor: ColorConstants.dividerColor,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(65), child: image(formCubit)),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: _editButton(
            formCubit,
            () async {
              if (Platform.isIOS) {
                await formCubit.permissionIOSGallery();
              } else {
                await formCubit.checkImageFromGallery();
              }
            },
          ),
        ),
        if (formCubit.state.pickedFile?.path != null)
          Positioned(
            top: 0,
            right: 10,
            child: _editButton(formCubit, () => formCubit.removeImage(),
                icon: Icons.close),
          )
      ],
    );
  }

  GestureDetector _editButton(
      ImagePickerCubit formCubit, void Function()? onTap,
      {IconData? icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
            color: ColorConstants.lightGrey, shape: BoxShape.circle),
        child: Icon(
          icon ?? Icons.edit,
          color: ColorConstants.grey,
        ),
      ),
    );
  }

  Widget image(ImagePickerCubit imagePickerCubit) {
    if (imagePickerCubit.state.pickedFile != null) {
      return Image.file(
        File(imagePickerCubit.state.pickedFile!.path),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return CashedImages(
        imageUrl: imageUrl,
        isSvg: true,
        isUser: true,
        height: double.infinity,
        width: double.infinity,
      );
    }
  }
}
