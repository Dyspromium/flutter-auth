import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  const InputField({
    this.controller,
    this.hintText,
    this.icon,
    this.obscureText,
    this.textInputAction,
    this.onEditingComplete,
  });

  final TextEditingController controller;
  final Icon icon;
  final String hintText;
  final bool obscureText;
  final TextInputAction textInputAction;
  final onEditingComplete;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: icon,
      ),
    );
  }
}
