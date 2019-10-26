import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/pages/pratos/prato_page.dart';
import 'package:projeto_restaurante/utils/nav.dart';

class ListaPrato extends StatelessWidget {
  final List<Prato> pratos;

  ListaPrato.prato(this.pratos);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: pratos.length,
        itemBuilder: (context, index) {
          Prato p = pratos[index];
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
    push(
        context,
        PratoPage(
          prato: p,
        ));
  }

  //TODO: Set Id.
  _addPrato(Prato p) {

    Conta conta;
    Firestore.instance
        .collection("Mesas")
        .document(Mesa.id)
        .collection("Pedidos")
        .document()
        .setData({"prato": p.nome, "valor": p.valor});

  }
}
