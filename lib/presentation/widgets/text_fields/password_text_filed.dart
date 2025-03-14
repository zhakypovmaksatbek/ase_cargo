import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.textInputAction,
      this.validator,
      this.errorText,
      this.onChanged,
      this.onEditingComplete});
  final String hintText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String? errorText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isVisible = false;
  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_isVisible,
      keyboardType: TextInputType.visiblePassword,
      controller: widget.controller,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: IconButton(
          onPressed: _toggleVisibility,
          icon: Icon(
            _isVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
      ),
    );
  }
}
