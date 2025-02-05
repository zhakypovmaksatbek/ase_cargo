import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.textInputAction,
    this.validator,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
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
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: _toggleVisibility,
          icon: Icon(
            _isVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
