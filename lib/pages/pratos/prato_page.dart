import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/drawer_list.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';

class PratoPage extends StatefulWidget {
  Prato prato = Prato();

  PratoPage({this.prato});

  @override
  _PratoPageState createState() => _PratoPageState();
}

class _PratoPageState extends State<PratoPage> {
  FirebaseUser currentUser;
  bool admin;
  bool switchOn;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _verificaSwitch();
  }

  _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  _verificaSwitch() {
    if (prato.disponivel == true) {
      switchOn = true;
    } else {
      switchOn = false;
    }
  }

  Prato get prato => widget.prato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.displayName),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection("Clientes")
            .document(currentUser.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text("Carregando...");
            default:
              return checkRole(snapshot.data);
          }
        },
      ),
      drawer: DrawerList(
        admin: admin,
      ),
    );
  }

  //Verifica o papel do usuário.
  checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data['role'] == 'admin') {
      admin = true;
      return _bodyAdmin();
    } else {
      admin = false;
      return _body();
    }
  }

  _bodyAdmin() {
    print(prato.id);
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(prato.urlFoto),
          Text(prato.descricao),
          Row(
            children: <Widget>[
              Switch(
                dragStartBehavior: DragStartBehavior.down,
                onChanged: _onSwitchChanged,
                value: switchOn,
              )
            ],
          )
        ],
      ),
    );
  }

  void _onSwitchChanged(bool value) {
    if (switchOn == true) {
      switchOn = false;
      prato.disponivel = false;

      Firestore.instance
          .collection("Pratos")
          .document(prato.id)
          .updateData({"disponivel": false});
    } else {
      switchOn = true;
      prato.disponivel = true;

      Firestore.instance
          .collection("Pratos")
          .document(prato.id)
          .updateData({"disponivel": true});
    }
    print(prato.disponivel);
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
    Conta c = Conta();
    var db = Firestore.instance
        .collection("Mesas")
        .document(Mesa.id)
        .collection("Pedidos")
        .document(prato.id.toString());

    try {
      //Prato.qtd = 1;
      db.updateData({
        "pedidoId": prato.id,
        "prato": prato.nome,
        "valor": prato.valor,
        "quantidade": Prato.qtd,
        "status": "pedindo"
      });
    } finally {
      Prato.qtd++;
      db.setData({
        "pedidoId": prato.id,
        "prato": prato.nome,
        "valor": prato.valor,
        "quantidade": Prato.qtd,
        "status": "pedindo"
      });
      c.total = double.parse(prato.valor) * Prato.qtd;
      print(c.total);
      Firestore.instance
          .collection("Mesas")

          .document(Mesa.id)
          .updateData({"total": c.total});
    }
  }
}
