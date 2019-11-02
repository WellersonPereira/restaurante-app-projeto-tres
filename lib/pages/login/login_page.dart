import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:projeto_restaurante/api_response.dart';
import 'package:projeto_restaurante/bg_login.dart';
import 'package:projeto_restaurante/firebase/firebase_service.dart';
import 'package:projeto_restaurante/pages/login/cadastro_page.dart';
import 'package:projeto_restaurante/pages/pratos/home.dart';
import 'package:projeto_restaurante/utils/alert.dart';
import 'package:projeto_restaurante/utils/nav.dart';
import 'package:projeto_restaurante/widgets/login_button.dart';
import 'package:projeto_restaurante/widgets/login_text.dart';

import '../../api_response.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tEmail = TextEditingController();
  final _tPassWord = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[BgLogin(), _body()],
      ),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset("assets/images/logo.png",
                  width: 230, height: 230),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: AppText(
                "Login",
                "joaozinho@hotmail.com",
                controller: _tEmail,
                validator: _validatorLogin,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: AppText("Senha", "Digite sua senha",
                  obscure: true,
                  validator: _validatorPassWord,
                  controller: _tPassWord),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: AppButton(
                "Login",
                _onClickLogin,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: GoogleSignInButton(
                text: "Entrar com Google",
                darkMode: false,
                onPressed: _onClickGoogle,
                borderRadius: 22,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _onClickRegister,
                    child: (Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Cadastre-se",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 16),
                      ),
                    )),
                  ),
                ),
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
    } else
      alert(
        context,
        response.msg
      );
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
    push(context, Cadastro());
  }
}
