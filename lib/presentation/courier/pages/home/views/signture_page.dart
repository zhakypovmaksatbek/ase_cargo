// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui' as ui;

import 'package:ase/data/bloc/box/box_cubit.dart';
import 'package:ase/data/bloc/image/image_picker_cubit.dart';
import 'package:ase/data/bloc/update_order_status/update_order_status_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/models/signature_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/bottom_sheet/def_bottom_sheet.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/annotations.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

@RoutePage(name: "SignatureRoute")
class SignaturePage extends StatefulWidget {
  const SignaturePage({
    super.key,
    required this.box,
  });
  final BoxModel box;

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  late final ImagePickerCubit _imageCubit;
  final nameController = TextEditingController();
  XFile? approveImage;
  @override
  void initState() {
    _imageCubit = ImagePickerCubit();
    super.initState();
  }

  @override
  void dispose() {
    _imageCubit.close();
    nameController.dispose();
    super.dispose();
  }

  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: _imageCubit,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: size.width * .85,
          child: DefElevatedButton(
            onPressed: () {
              final GlobalKey<SfSignaturePadState> signatureGlobalKey =
                  GlobalKey();
              void handleClearButtonPressed() {
                signatureGlobalKey.currentState!.clear();
              }

              Future<void> handleSaveButtonPressed() async {
                final image = await signatureGlobalKey.currentState!
                    .toImage(pixelRatio: 3.0);
                final byteData =
                    await image.toByteData(format: ui.ImageByteFormat.png);

                if (byteData != null) {
                  final buffer = byteData.buffer;
                  final directory = await getTemporaryDirectory();
                  final filePath = '${directory.path}/signature.png';
                  final file = File(filePath);

                  await file.writeAsBytes(buffer.asUint8List(
                      byteData.offsetInBytes, byteData.lengthInBytes));

                  XFile xFile = XFile(filePath);

                  if (kDebugMode)
                    print('Signature saved as XFile at: ${xFile.path}');
                  if (context.mounted) {
                    context.read<UpdateOrderStatusCubit>().doneOrder(
                        widget.box.code!,
                        SignatureModel(
                          approveImage: approveImage,
                          signatureImage: xFile,
                          recipientName: nameController.text,
                        ));
                  }
                }
              }

              AppBottomSheet.showDefBottomSheet(
                  context,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      SizedBox(),
                      AppText(
                          title: LocaleKeys.form_required_signature.tr(),
                          color: ColorConstants.lightBlack,
                          fontWeight: FontWeight.w600,
                          textType: TextType.header),
                      SizedBox(height: 10),
                      SfSignaturePad(
                        key: signatureGlobalKey,
                        minimumStrokeWidth: 1,
                        maximumStrokeWidth: 3,
                        strokeColor: Colors.black,
                        backgroundColor: Colors.grey[200],
                        onDrawEnd: () {},
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: handleClearButtonPressed,
                            child: AppText(
                              title: LocaleKeys.button_clear.tr(),
                              textType: TextType.body,
                            ),
                          ),
                          BlocConsumer<UpdateOrderStatusCubit,
                              UpdateOrderStatusState>(
                            listener: (context, state) {
                              if (state is UpdateOrderStatusSuccess) {
                                context
                                    .read<BoxCubit>()
                                    .getBox(CourierOrderStatus.active);
                                router.back();
                              } else if (state is UpdateOrderStatusError) {
                                CherryToast.error(
                                  title:
                                      Text(LocaleKeys.exception_exception.tr()),
                                  description: Text(state.message),
                                  animationType: AnimationType.fromTop,
                                ).show(context);
                              }
                            },
                            builder: (context, state) {
                              if (state is UpdateOrderStatusLoading) {
                                return SizedBox(
                                  width: 100,
                                  child: const Center(
                                    child: LoadingWidget(),
                                  ),
                                );
                              }
                              return TextButton(
                                onPressed: handleSaveButtonPressed,
                                child: AppText(
                                  title: LocaleKeys.button_confirm.tr(),
                                  textType: TextType.body,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                    ],
                  ));
            },
            text: LocaleKeys.button_confirm.tr(),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            DefSliverAppBar(title: LocaleKeys.navigation_delivered_order.tr()),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    const SizedBox(),
                    Container(
                      decoration: CustomBoxDecoration().copyWith(),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          AppText(
                              title: LocaleKeys.form_delivered_package.tr(),
                              fontWeight: FontWeight.w600,
                              textType: TextType.header),
                          AppText(
                              title: LocaleKeys
                                  .form_delivered_package_description
                                  .tr(),
                              textType: TextType.body),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: CustomBoxDecoration().copyWith(
                                color: ColorConstants.lightSlate,
                              ),
                              child: AppText(
                                title: (widget.box.code ?? "").toLowerCase(),
                                textType: TextType.header,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    AppText(
                      title: LocaleKeys.form_who_receive.tr(),
                      textType: TextType.header,
                      fontWeight: FontWeight.w600,
                    ),
                    DefTextField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      hintText: LocaleKeys.form_full_name.tr(),
                    ),
                    SizedBox(height: 20),
                    AppText(
                      title: "${LocaleKeys.form_upload_approve_image.tr()}:",
                      textType: TextType.header,
                      fontWeight: FontWeight.w600,
                    ),
                    BlocBuilder<ImagePickerCubit, FeedbackImagePickerState>(
                      builder: (context, state) {
                        if (state.pickedFile != null) {
                          approveImage = state.pickedFile;
                          return Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: size.width / 2,
                                child: Image.file(File(state.pickedFile!.path)),
                              ),
                              _removeButton(),
                            ],
                          );
                        }

                        return SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                              onPressed: () {
                                AppBottomSheet.showCupertinoBottomSheet(
                                  context,
                                  Container(),
                                  firstActionTap: () {
                                    _imageCubit.pickImage(
                                        context, ImageType.signature);
                                  },
                                  secondActionTap: () {
                                    _imageCubit.pickImage(
                                        context, ImageType.signature);
                                  },
                                  title: LocaleKeys.form_upload_photo.tr(),
                                  message: LocaleKeys
                                      .notification_upload_photo_description
                                      .tr(),
                                );
                              },
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
                              label: AppText(
                                  title: LocaleKeys.form_upload_photo.tr(),
                                  textType: TextType.body),
                              icon: CustomAssetImage(
                                path: AssetConstants.uploadImage.svg,
                                isSvg: true,
                              )),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Align _removeButton() {
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
        icon: Icon(
          Icons.close,
          color: ColorConstants.white,
        ),
      ),
    );
  }
}
