import 'package:flutter/material.dart';
import 'package:projeto_restaurante/bg_login.dart';
import 'package:projeto_restaurante/firebase/firebase_service.dart';
import 'package:projeto_restaurante/pages/login/login_page.dart';
import 'package:projeto_restaurante/pages/pratos/home.dart';
import 'package:projeto_restaurante/utils/alert.dart';
import 'package:projeto_restaurante/utils/nav.dart';
import 'package:projeto_restaurante/widgets/login_button.dart';
import 'package:projeto_restaurante/widgets/login_text.dart';
import 'package:toast/toast.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final _tName = TextEditingController();
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();

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
            Center(
              child: Text(
                "Cadastro",
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
            ),
            //TODO: Implementar focus;
            Container(
              padding: EdgeInsets.only(top: 16),
              child: AppText(
                "Nome",
                "Informe seu nome",
                controller: _tName,
                validator: _validateName,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: AppText(
                "Email",
                "Informe seu Email",
                controller: _tEmail,
                validator: _validateEmail,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: AppText(
                "Senha",
                "Informe sua senha",
                controller: _tPassword,
                validator: _validatePassword,
                obscure: true,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              child: AppButton(
                "Cadastrar-se",
                _onClickRegister,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickRegister() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print("Cadastrar");

    String name = _tName.text;
    String email = _tEmail.text;
    String password = _tPassword.text;

    final service = FirebaseService();
    final response = await service.cadastrar(name, email, password);

    if (response.ok) {
      push(context, LoginPage(), replace: true);
      Toast.show("Usuário criado com sucesso", context, duration: Toast.LENGTH_LONG);
    } else
      alert(
        context,
        response.msg,
      );
  }

  String _validateName(String text) {
    if (text.isEmpty) {
      return "Digite seu nome";
    }
    return null;
  }

  String _validateEmail(String text) {
    if (text.isEmpty) {
      return "Digite um email válido";
    }
    return null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 6 caractéres";
    }
    return null;
  }
}
