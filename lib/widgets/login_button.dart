import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  Function onPressed;
  Color bntColor;
  Color textColor;

  AppButton(this.text, {this.onPressed, this.bntColor = Colors.green, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 180,
      child: RaisedButton(
        color: bntColor,
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: textColor),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
