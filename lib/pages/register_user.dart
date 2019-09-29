import 'package:flutter/material.dart';

class RegisterUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Usuário"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text(
        "Resgister Page",
        style: TextStyle(fontSize: 36, color: Colors.green),
      ),
    );
  }
}
