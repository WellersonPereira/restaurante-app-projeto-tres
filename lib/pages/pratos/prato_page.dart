import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';

class PratoPage extends StatefulWidget {
  Prato prato = Prato();

  PratoPage({this.prato});

  @override
  _PratoPageState createState() => _PratoPageState();
}

class _PratoPageState extends State<PratoPage> {
  Prato get prato => widget.prato;

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
          Image.network(prato.urlFoto),
          Text(prato.descricao),
          FlatButton(
              child: const Text("Quero"), onPressed: () => _addPrato(prato))
        ],
      ),
    );
  }

  //TODO: Set Id.
  _addPrato(Prato prato) {
    var db = Firestore.instance
        .collection("Mesas")
        .document(Mesa.id)
        .collection("Pedidos")
        .document(prato.id.toString());

    try {
      //Prato.qtd = 1;
      Firestore.instance
          .collection("Mesas")
          .document(Mesa.id)
          .collection("Pedidos")
          .document(prato.id.toString())
          .updateData({
        "prato": prato.nome,
        "valor": prato.valor,
        "quantidade": Prato.qtd
      });
      print(false);
    } finally {
      Prato.qtd++;
      db.setData(
          {"prato": prato.nome, "valor": prato.valor, "quantidade": Prato.qtd});
      print(Prato.qtd);
      Conta.pratoId = prato.id.toString();
      Prato.qtd = Prato.qtd;
    }
    //{"prato": prato.nome, "valor": prato.valor, "quantidade": prato.qtd}
  }
}
