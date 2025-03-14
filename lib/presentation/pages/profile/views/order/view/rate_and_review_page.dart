// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/data/bloc/review_action/review_action_cubit.dart';
import 'package:ase/data/models/review_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/bottom_sheet/def_bottom_sheet.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/error/error_toast.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/rating/star_rating_selector.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage(name: "RateAndReviewRoute")
class RateAndReviewPage extends StatefulWidget {
  const RateAndReviewPage({
    super.key,
    required this.code,
  });
  final String code;
  @override
  State<RateAndReviewPage> createState() => _RateAndReviewPageState();
}

class _RateAndReviewPageState extends State<RateAndReviewPage> {
  late final ImagePickerCubit _imageCubit;
  late final TextEditingController _review;
  late final ReviewActionCubit _reviewActionCubit;
  XFile? approveImage;
  int rating = 5;

  @override
  void initState() {
    super.initState();
    _review = TextEditingController();
    _imageCubit = ImagePickerCubit();
    _reviewActionCubit = ReviewActionCubit();
  }

  @override
  void dispose() {
    _imageCubit.close();
    _review.dispose();
    _reviewActionCubit.close();
    super.dispose();
  }

  static final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _reviewActionCubit,
      child: BlocListener<ReviewActionCubit, ReviewActionState>(
        listener: (context, state) {
          if (state is ReviewSendSuccess) {
            ErrorToast.defSuccessToast(
                context, LocaleKeys.notification_review_sent.tr());

            router.back();
          } else if (state is ReviewActionError) {
            ErrorToast.defExceptionToast(context, state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.navigation_rate_and_review.tr()),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  AppText(
                    title: LocaleKeys.navigation_rate.tr(),
                    textType: TextType.body,
                    fontWeight: FontWeight.w600,
                  ),
                  StarRatingSelector(
                    initialRating: rating,
                    onRatingSelected: (value) {
                      rating = value;
                    },
                  ),
                  DefTextField(
                    keyboardType: TextInputType.name,
                    controller: _review,
                    maxLines: 10,
                    minLines: 1,
                    textInputAction: TextInputAction.done,
                    hintText: LocaleKeys.form_write_comment.tr(),
                  ),
                  const SizedBox(height: 20),
                  AppText(
                    title: "${LocaleKeys.form_upload_approve_image.tr()}:",
                    textType: TextType.header,
                    fontWeight: FontWeight.w600,
                  ),
                  BlocBuilder<ImagePickerCubit, FeedbackImagePickerState>(
                    buildWhen: (previous, current) =>
                        previous.pickedFile != current.pickedFile,
                    builder: (context, state) {
                      if (state.pickedFile != null) {
                        approveImage = state.pickedFile;
                        return _buildImagePreview(state.pickedFile!, size);
                      }

                      return _buildUploadButton(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<ReviewActionCubit, ReviewActionState>(
                      builder: (context, state) {
                        if (state is ReviewActionLoading) {
                          return Center(child: LoadingWidget());
                        }
                        return DefElevatedButton(
                          text: LocaleKeys.button_send.tr(),
                          onPressed: () {
                            _reviewActionCubit.sendReview(
                              ReviewModel(
                                comment: _review.text,
                                rating: rating,
                                imageFile: approveImage,
                              ),
                              widget.code,
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(XFile file, Size size) {
    return Stack(
      children: [
        RepaintBoundary(
          child: SizedBox(
            width: double.infinity,
            height: size.width / 2,
            child: Image.file(
              File(file.path),
              cacheWidth: (size.width * MediaQuery.of(context).devicePixelRatio)
                  .toInt(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        _removeButton(),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showImagePickerSheet(context),
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorConstants.white,
          side: BorderSide(
            color: ColorConstants.primary,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: CustomAssetImage(
          path: AssetConstants.uploadImage.svg,
          isSvg: true,
        ),
        label: AppText(
          title: LocaleKeys.form_upload_photo.tr(),
          textType: TextType.body,
        ),
      ),
    );
  }

  void _showImagePickerSheet(BuildContext context) {
    AppBottomSheet.showCupertinoBottomSheet(
      context,
      Container(),
      firstActionTap: () {
        _imageCubit.pickImage(context, ImageType.signature);
      },
      secondActionTap: () {
        _imageCubit.pickImage(context, ImageType.signature);
      },
      title: LocaleKeys.form_upload_photo.tr(),
      message: LocaleKeys.notification_upload_photo_description.tr(),
    );
  }

  Widget _removeButton() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: ColorConstants.black.withValues(alpha: .6),
        ),
        onPressed: () {
          approveImage = null;
          _imageCubit.removePickImage(ImageType.signature);
        },
        icon: const Icon(
          Icons.close,
          color: ColorConstants.white,
        ),
      ),
    );
  }
}
