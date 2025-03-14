// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:ase/data/bloc/update_order_status/update_order_status_cubit.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/presentation/widgets/text_fields/def_text_field.dart';
import 'package:ase/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelContentWidget extends StatefulWidget {
  const CancelContentWidget({
    super.key,
    required this.box,
  });
  final BoxModel box;

  @override
  State<CancelContentWidget> createState() => _CancelContentWidgetState();
}

class _CancelContentWidgetState extends State<CancelContentWidget>
    with CancelContentMixin {
  @override
  void initState() {
    super.initState();
    _reasonController.addListener(checkValid);
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _isValid.dispose();
    _reasonController.removeListener(checkValid);
    formKey.currentState?.dispose();
    super.dispose();
  }

  final router = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
            onChanged: checkValid,
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                SizedBox(),
                AppText(
                  title: LocaleKeys.notification_cancel_delivery.tr(),
                  textType: TextType.header,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  title:
                      LocaleKeys.notification_cancel_delivery_description.tr(),
                  textType: TextType.body,
                  color: ColorConstants.red,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    key: PageStorageKey('reason_list_scroll'),
                    itemCount: reasonList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ChoiceChip(
                        label: Text(reasonList[index]),
                        selected: false,
                        onSelected: (value) {
                          _reasonController.text = reasonList[index];
                        },
                      );
                    },
                  ),
                ),
                DefTextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: _reasonController,
                  hintText:
                      LocaleKeys.notification_cancel_delivery_description.tr(),
                  onChanged: (value) {},
                ),
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder(
                      valueListenable: _isValid,
                      builder: (context, isValid, child) {
                        return DefElevatedButton(
                          text: LocaleKeys.button_cancel.tr(),
                          backgroundColor: ColorConstants.red,
                          onPressed: isValid
                              ? () {
                                  context
                                      .read<UpdateOrderStatusCubit>()
                                      .cancelOrder(widget.box.code ?? "",
                                          _reasonController.text);
                                  router.pop();
                                }
                              : null,
                        );
                      }),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}

mixin CancelContentMixin on State<CancelContentWidget> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _reasonController = TextEditingController();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);

  void checkValid() {
    _isValid.value = _reasonController.text.isNotEmpty;
  }

  final UnmodifiableListView<String> reasonList = UnmodifiableListView([
    LocaleKeys.notification_cancel_delivery_reason_1.tr(),
    LocaleKeys.notification_cancel_delivery_reason_2.tr(),
    LocaleKeys.notification_cancel_delivery_reason_3.tr(),
    LocaleKeys.notification_cancel_delivery_reason_4.tr(),
  ]);
}
