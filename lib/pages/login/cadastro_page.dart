import 'package:flutter/material.dart';
import 'package:projeto_restaurante/firebase/firebase_service.dart';
import 'package:projeto_restaurante/pages/cardapio.dart';
import 'package:projeto_restaurante/pages/pratos/home.dart';
import 'package:projeto_restaurante/utils/alert.dart';
import 'package:projeto_restaurante/utils/nav.dart';
import 'package:projeto_restaurante/widgets/login_button.dart';
import 'package:projeto_restaurante/widgets/login_text.dart';

import 'login_page.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final _tName = TextEditingController();
  final _tEmail = TextEditingController();
  final _tCpf = TextEditingController();
  final _tPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cadastro"),
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
            //TODO: Implementar focus;
            AppText(
              "Nome",
              "Informe seu nome",
              controller: _tName,
              validator: _validateName,
            ),
            SizedBox(height: 10),
            AppText(
              "Email",
              "Informe seu Email",
              controller: _tEmail,
              validator: _validateEmail,
            ),
            SizedBox(height: 10),
            AppText(
              "Senha",
              "Informe sua senha",
              controller: _tPassword,
              validator: _validatePassword,
              obscure: true,
            ),
            SizedBox(height: 10),
            AppButton(
              "Cadastrar",
              onPressed: () {
                _onClickRegister();
              },
            ),
            SizedBox(height: 10,),
            AppButton(
              "Cancelar", bntColor: Colors.white, textColor: Colors.green,
              onPressed: _onClickCancel,
            )
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

    print("Cadastrado Sr.$name $email");

    final service = FirebaseService();
    final response = await service.cadastrar(name, email, password);

    if (response.ok) {
      push(context, HomePage(), replace: true);
    }
    else
      alert(context, response.msg,);
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

  _onClickCancel() {
    push(context, LoginPage(), replace: true);
  }
}
