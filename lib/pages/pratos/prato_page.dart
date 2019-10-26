import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/model/mesa.dart';

class PratoPage extends StatefulWidget {
  Prato prato;
  String id;

  PratoPage({this.prato, this.id});

  @override
  _PratoPageState createState() => _PratoPageState();
}

class _PratoPageState extends State<PratoPage> {
  String get id => widget.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prato.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(widget.prato.urlFoto),
          Text(widget.prato.descricao),
          FlatButton(child: const Text("Quero"), onPressed: _addPrato)
        ],
      ),
    );
  }

  _addPrato() {
    Firestore.instance
        .collection("Mesas")
        .document()
        .collection("Pedidos")
        .add({"prato": widget.prato.nome, "valor": widget.prato.valor});
  }
}
