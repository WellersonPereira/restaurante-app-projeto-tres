import 'package:flutter/material.dart';
import 'package:projeto_restaurante/pages/register_user.dart';
import 'package:projeto_restaurante/utils/nav.dart';
import 'package:projeto_restaurante/widgets/login_button.dart';
import 'package:projeto_restaurante/widgets/login_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tLogin = TextEditingController();
  final _tPassWord = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurante"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            LoginText(
              "Email",
              "joaozinho@hotmail.com",
              controller: _tLogin,
              validator: _validatorLogin,
            ),
            SizedBox(height: 10),
            LoginText("Senha", "Digite sua senha",
                obscure: true,
                validator: _validatorPassWord,
                controller: _tPassWord),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppButton("Entrar", onPressed: _onClickLogin),
                SizedBox(width: 10),
                AppButton(
                  "Cadastrar",
                  onPressed: _onClickRegister,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _onClickLogin() {
    if (!_formKey.currentState.validate()) {
      return;
    }
  }

  String _validatorLogin(String text) {
    if (text.isEmpty) {
      return "Digite o email";
    }
    return null;
  }

  String _validatorPassWord(String text) {
    if (text.isEmpty) {
      return "Digite sua senha";
    }
    if (text.length < 5) {
      return "A senha deve ter ao menos 5 números";
    }
    return null;
  }

  _onClickRegister() {
    push(context, RegisterUser());
  }
}
