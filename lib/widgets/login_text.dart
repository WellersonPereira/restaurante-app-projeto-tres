import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  String label;
  String hint;
  bool obscure = false;
  TextEditingController controller;
  FormFieldValidator<String> validator;

  LoginText(
    this.label,
    this.hint, {
    this.obscure = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      validator: validator,
      style: TextStyle(
        fontSize: 25,
        color: Colors.green,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: 25, color: Colors.blueGrey),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}
