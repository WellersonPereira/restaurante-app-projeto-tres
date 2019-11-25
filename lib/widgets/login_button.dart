import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool showProgress;
  final double largura;

  AppButton(this.text, this.callback, {this.showProgress = false, this.largura = 200});

  @override
  Widget build(BuildContext context) {
    final backgroundColor1 = Colors.indigoAccent;
    final backgroundColor2 = Colors.indigo;
    final textColor = Colors.white;

    return Container(
      width: largura,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [backgroundColor1, backgroundColor2],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          )),
      child: FlatButton(
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              ),
        onPressed: callback,
      ),
    );
  }
}
