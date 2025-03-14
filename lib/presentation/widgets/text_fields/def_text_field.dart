import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String? Function(String?)? validator;
  final String? errorText;
  final void Function(String)? onChanged;
  final bool? enabled;
  final int? maxLines;
  final int? minLines;
  final void Function()? onTap;

  const DefTextField(
      {super.key,
      this.controller,
      required this.keyboardType,
      required this.textInputAction,
      this.decoration,
      this.inputFormatters,
      required this.hintText,
      this.validator,
      this.errorText,
      this.onChanged,
      this.enabled,
      this.maxLines,
      this.minLines,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onTap: onTap,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      inputFormatters: inputFormatters,
      decoration: decoration ??
          InputDecoration(
            errorText: errorText,
            hintText: hintText,
          ),
    );
  }
}
