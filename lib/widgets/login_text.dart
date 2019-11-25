import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool obscure = false;
  TextEditingController controller;
  FormFieldValidator<String> validator;

  AppText(
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
        color: Colors.white //fromRGBO(0, 51, 0, 10),
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: 25, color: Colors.white),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
