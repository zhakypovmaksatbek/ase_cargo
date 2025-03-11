import 'package:ase/data/bloc/update_password/update_password_cubit.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/products/utils/validation.dart';
import 'package:ase/presentation/widgets/app_bar/def_sliver_app_bar.dart';
import 'package:ase/presentation/widgets/buttons/def_elevated_button.dart';
import 'package:ase/presentation/widgets/loading/loading_widget.dart';
import 'package:ase/presentation/widgets/text_fields/password_text_filed.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: "ChangePasswordRoute")
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});
  static final router = getIt<AppRouter>();

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordCtrl = TextEditingController();

  final TextEditingController _newPasswordCtrl = TextEditingController();

  final TextEditingController _confirmPasswordCtrl = TextEditingController();

  final _validate = InputValidate.instance;

  final formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> ready = ValueNotifier<bool>(false);

  void validateForm() {
    if (formKey.currentState!.validate()) {
      ready.value = true;
    } else {
      ready.value = false;
    }
  }

  String? errorMessage;

  @override
  void dispose() {
    _oldPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
      listener: _updatePasswordState,
      builder: (context, state) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            DefSliverAppBar(title: LocaleKeys.navigation_change_password.tr()),
            SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                  child: Form(
                    key: formKey,
                    onChanged: validateForm,
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 30),
                        PasswordTextField(
                            hintText: LocaleKeys.form_old_password.tr(),
                            validator: _validate.validatePassword,
                            controller: _oldPasswordCtrl),
                        PasswordTextField(
                            hintText: LocaleKeys.form_new_password.tr(),
                            errorText: errorMessage,
                            validator: _validate.validatePassword,
                            onChanged: (value) {
                              errorMessage = null;
                              validateForm();
                            },
                            controller: _newPasswordCtrl),
                        PasswordTextField(
                            hintText: LocaleKeys.form_confirm_password.tr(),
                            validator: (value) =>
                                _validate.validateConfirmPassword(
                                    value, _newPasswordCtrl.text),
                            controller: _confirmPasswordCtrl),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child:
                                  Text(LocaleKeys.button_forgot_password.tr())),
                        ),
                        ValueListenableBuilder<bool>(
                            valueListenable: ready,
                            builder: (context, value, _) {
                              return SizedBox(
                                  width: double.infinity,
                                  child: BlocBuilder<UpdatePasswordCubit,
                                      UpdatePasswordState>(
                                    builder: (context, state) {
                                      if (state is UpdatePasswordLoading) {
                                        return Center(child: LoadingWidget());
                                      }
                                      return DefElevatedButton(
                                        text: LocaleKeys.button_save.tr(),
                                        onPressed: value
                                            ? () {
                                                context
                                                    .read<UpdatePasswordCubit>()
                                                    .updatePassword(
                                                        _oldPasswordCtrl.text,
                                                        _newPasswordCtrl.text);
                                              }
                                            : null,
                                      );
                                    },
                                  ));
                            })
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _updatePasswordState(context, state) {
    if (state is UpdatePasswordSuccess) {
      _confirmPasswordCtrl.clear();
      _newPasswordCtrl.clear();
      _oldPasswordCtrl.clear();
      ChangePasswordPage.router.back();
    } else if (state is UpdatePasswordError) {
      if (state.errorMessage.detail != null) {
        CherryToast.error(
          title: Text(LocaleKeys.exception_exception.tr()),
          description: Text(state.errorMessage.detail ??
              LocaleKeys.exception_something_went_wrong_try_again.tr()),
          animationType: AnimationType.fromTop,
        ).show(context);
      } else if (state.errorMessage.newPassword != null) {
        errorMessage = state.errorMessage.newPassword?.firstOrNull ?? "";
      }
    }
  }
}
