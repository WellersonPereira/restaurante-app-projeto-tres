import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';

class PratoPage extends StatelessWidget {
  Prato prato;

  PratoPage(this.prato);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prato.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(prato.fotoUrl),
    );
  }
}
