import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:projeto_restaurante/api_response.dart';
import 'package:projeto_restaurante/firebase/firebase_service.dart';
import 'package:projeto_restaurante/pages/home_page.dart';
import 'package:projeto_restaurante/pages/login_block.dart';
import 'package:projeto_restaurante/pages/register_user.dart';
import 'package:projeto_restaurante/utils/alert.dart';
import 'package:projeto_restaurante/utils/nav.dart';
import 'package:projeto_restaurante/widgets/login_button.dart';
import 'package:projeto_restaurante/widgets/login_text.dart';

import '../api_response.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _streamController = StreamController<bool>();
  final _formKey = GlobalKey<FormState>();
  final _tEmail = TextEditingController();
  final _tPassWord = TextEditingController();
  final _bloc = LoginBloc();

  @override
  void initState() {
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
            AppText(
              "Email",
              "joaozinho@hotmail.com",
              controller: _tEmail,
              validator: _validatorLogin,
            ),
            SizedBox(height: 10),
            AppText("Senha", "Digite sua senha",
                obscure: true,
                validator: _validatorPassWord,
                controller: _tPassWord),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                AppButton(
                  "Entrar",
                  onPressed: _onClickLogin,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: StreamBuilder<bool>(
                      stream: _streamController.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        return AppButton(
                  "Novato",
                  onPressed: _onClickRegister,
                );
                      }
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: GoogleSignInButton(
                text: "Entrar com Google",
                onPressed: _onClickGoogle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickGoogle() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();

    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }
  }

  _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String email = _tEmail.text;
    String password = _tPassWord.text;

    final service = FirebaseService();
    final response = await service.login(email, password);

    if (response.ok) {
      push(context, HomePage(), replace: true);
    }
    else
      alert(context, response.msg,);

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
    push(context, RegisterUser(), replace: true);
  }
}
