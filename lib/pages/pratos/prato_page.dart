import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/bg_login.dart';
import 'package:projeto_restaurante/drawer_list.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/widgets/login_button.dart';
import 'package:toast/toast.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _desc = TextEditingController();

  @override
  void initState() {
    Prato.qtd = 0;
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
        title: Text("Restaurante"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
//          BgLogin(),
          StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("Clientes")
                .document(currentUser.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
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
          )
        ],
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

  //--------------------- If Admin -------------------
  _bodyAdmin() {
    print(prato.id);
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(prato.urlFoto, width: 250, height: 250,),
          Container(padding: EdgeInsets.fromLTRB(10,20,10,15), child: Text(prato.descricao, style: TextStyle(fontSize: 25),), width: 100,),
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

  // ----------------------------------If user --------------------------------
  _body() {
    return Container(
      key: _formKey,
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(prato.urlFoto ,width: 250, height: 250,),
          Container(
            child: Text(
              "Descrição do prato: \n" + prato.descricao,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            padding: EdgeInsets.all(15),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Ex.: Tirar o queijo "),
              controller: _desc,
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AppButton("Add", () => _addPrato(prato), largura: 160),
                  AppButton("Voltar", () {
                    Navigator.pop(context);
                  }, largura: 160)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _addPrato(Prato prato) {
    Conta c = Conta();
    c.desc = _desc.text;
    c.mesa = Mesa.id;
    var db = Firestore.instance
        .collection("Mesas")
        .document(c.mesa)
        .collection("Pedidos")
        .document(prato.id.toString());

    //double valor = Prato.qtd * double.parse(prato.valor);

    try {
      //Prato.qtd = 1;
      db.updateData({
        "pedidoId": prato.id,
        "prato": prato.nome,
        "valor": prato.valor,
        "descricao": c.desc,
        "quantidade": Prato.qtd,
        "status": "Aguardando confirmação",
        "mesa": c.mesa
      });
      double total = double.parse(prato.valor) * Prato.qtd;
      c.total = total + c.total;
      Firestore.instance
          .collection("Mesas")
          .document(c.mesa)
          .updateData({"total": c.total});
      print(c.total);

    } finally {
      Prato.qtd++;
      db.setData(
        {
          "pedidoId": prato.id,
          "prato": prato.nome,
          "valor": prato.valor,
          "descricao": c.desc,
          "quantidade": Prato.qtd,
          "status": "Aguardando confirmação",
          "mesa": c.mesa
        },
      );
      Toast.show("Prato enviado para lista de pedido", context);
    }
  }
}
