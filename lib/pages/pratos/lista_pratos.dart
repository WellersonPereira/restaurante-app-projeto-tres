import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/pages/pratos/prato_page.dart';
import 'package:projeto_restaurante/utils/nav.dart';

class ListaPrato extends StatefulWidget {
  final List<Prato> pratos;

  ListaPrato.prato(this.pratos);

  @override
  _ListaPratoState createState() => _ListaPratoState();
}

class _ListaPratoState extends State<ListaPrato> {

  @override
  void initState() {
    // TODO: implement initState
    Prato.qtd = 0;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: widget.pratos.length,
        itemBuilder: (context, index) {
          Prato p = widget.pratos[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      p.urlFoto ?? "",
                      width: 250,
                    ),
                  ),
                  Text(
                    p.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    p.descricao,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text("R\$" + p.valor),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickPrato(context, p),
                        ),
                        FlatButton(
                            child: const Text('Quero'),
                            onPressed: () => _addPrato(p)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickPrato(BuildContext context, Prato p) {
    push(context, PratoPage(prato: p));
  }

  _addPrato(Prato prato) {
    var db = Firestore.instance
        .collection("Mesas")
        .document(Mesa.id)
        .collection("Pedidos")
        .document(prato.id.toString());

    try{
      //Prato.qtd = 1;
      Firestore.instance
          .collection("Mesas")
          .document(Mesa.id)
          .collection("Pedidos")
          .document(prato.id.toString())
          .updateData(
          {"prato": prato.nome, "valor": prato.valor, "quantidade": Prato.qtd});
      print(false);
    }finally{
      Prato.qtd++;
      db.setData({"prato": prato.nome, "valor": prato.valor, "quantidade": Prato.qtd});
      print(Prato.qtd);
      Conta.pratoId = prato.id.toString();
      Conta.quantidade = Prato.qtd;
    }

    /*if (db.get() == null) {
      int qtd = Prato.qtd;
      qtd++;
      db.setData({"prato": prato.nome, "valor": prato.valor, "quantidade": qtd});
      print(qtd);
      Conta.pratoId = prato.id.toString();
    }

    else {
      Prato.qtd = 1;
      Firestore.instance
          .collection("Mesas")
          .document(Mesa.id)
          .collection("Pedidos")
          .document(prato.id.toString())
          .updateData(
          {"prato": prato.nome, "valor": prato.valor, "quantidade": Prato.qtd});
      print(false);

    }*/
  }
}
