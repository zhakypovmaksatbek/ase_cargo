import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String? Function(String?)? validator;

  const DefTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    this.decoration,
    this.inputFormatters,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      inputFormatters: inputFormatters,
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
          ),
    );
  }
}
