import 'dart:async';

import 'package:ase/data/bloc/resent_code/resent_code_cubit.dart';
import 'package:ase/data/bloc/verify/verify_cubit.dart';
import 'package:ase/data/models/verify_model.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/presentation/constants/asset_constants.dart';
import 'package:ase/presentation/widgets/image/custom_asset_image.dart';
import 'package:ase/presentation/widgets/pin/verify_pin.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:ase/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: 'VerifyRoute')
class VerifyPage extends StatefulWidget {
  const VerifyPage({
    super.key,
    required this.model,
    required this.title,
  });
  final VerifyModel model;
  final String title;

  @override
  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final ValueNotifier<bool> isActiveResendCode = ValueNotifier(false);
  final ValueNotifier<int> time = ValueNotifier(seconds);
  Timer? _timer;
  String? token;
  @override
  void initState() {
    _resendCode();
    code.value = widget.model.code;
    token = widget.model.verifyToken;
    super.initState();
  }

  ValueNotifier<String?> code = ValueNotifier(null);
  static const seconds = 90;
  Future<void> _resendCode() async {
    isActiveResendCode.value = false;
    time.value = seconds;
    _timer?.cancel();
    if (!isActiveResendCode.value) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        time.value--;
        if (time.value == 0) {
          timer.cancel();
          isActiveResendCode.value = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    time.dispose();
    isActiveResendCode.dispose();

    super.dispose();
  }

  final router = getIt.get<AppRouter>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocListener<ResentCodeCubit, ResentCodeState>(
      listener: (context, state) {
        if (state is ResentCodeSuccess) {
          code.value = state.model.testCode;
          token = state.model.verifyToken;
        }
      },
      child: BlocConsumer<VerifyCubit, VerifyState>(
        bloc: context.read<VerifyCubit>(),
        listener: verifyState,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.navigation_verify.tr()),
            ),
            body: Center(
              child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    spacing: 6,
                    children: [
                      CustomAssetImage(
                        path: AssetConstants.icon.png,
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: size.height * 0.08),
                      AppText(
                        title: widget.title,
                        textType: TextType.title,
                      ),
                      if (code.value != null)
                        ValueListenableBuilder(
                            valueListenable: code,
                            builder: (context, value, child) {
                              return AppText(
                                title: value ?? "",
                                textType: TextType.title,
                              );
                            }),
                      AppText(
                        title: LocaleKeys
                            .notification_we_sent_code_to_your_phone
                            .tr(),
                        textType: TextType.subtitle,
                        color: theme.hintColor,
                      ),
                      SizedBox(height: 6),
                      BlocBuilder<VerifyCubit, VerifyState>(
                        builder: (context, state) {
                          final errorText =
                              state is VerifyError ? state.message : null;
                          return Column(
                            spacing: 6,
                            children: [
                              VerifyPin(
                                controller: pinController,
                                errorText: errorText?.code?.firstOrNull,
                                onChanged: (p0) {
                                  context.read<VerifyCubit>().clearError();
                                },
                                onCompleted: (p0) {
                                  FocusScope.of(context).unfocus();
                                  context
                                      .read<VerifyCubit>()
                                      .verify(VerifyModel(
                                        code: pinController.text,
                                        phone: widget.model.phone,
                                        verifyToken: token,
                                      ));
                                },
                              ),
                              if (errorText != null)
                                AppText(
                                  title: errorText.code?.firstOrNull ?? "",
                                  textType: TextType.subtitle,
                                  color: theme.colorScheme.error,
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 6),
                      ValueListenableBuilder(
                          valueListenable: isActiveResendCode,
                          builder: (context, value, child) {
                            return TextButton(
                                onPressed: value
                                    ? () {
                                        _resendCode();
                                        if (widget.model.phone != null) {
                                          context
                                              .read<ResentCodeCubit>()
                                              .resentCode(
                                                  widget.model.phone ?? "0");
                                        }
                                      }
                                    : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    Text(LocaleKeys.button_resend_code.tr()),
                                    ValueListenableBuilder<int>(
                                        valueListenable: time,
                                        builder: (context, value, child) {
                                          if (value == 0) {
                                            return SizedBox.shrink();
                                          }
                                          return Text(
                                              "($value ${LocaleKeys.general_seconds.tr()})");
                                        }),
                                  ],
                                ));
                          })
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  void verifyState(context, state) {
    if (state is VerifySuccess) {
      router.replaceAll([const HomeRoute()]);
    }
  }
}
