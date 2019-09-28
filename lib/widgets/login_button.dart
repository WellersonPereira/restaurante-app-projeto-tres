import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  String text;
  Function onPressed;

  LoginButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.green,
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
