import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/model/prato.dart';

class ShowConta extends StatefulWidget {
  List<Conta> conta;

  ShowConta.conta(this.conta);

  @override
  _ShowContaState createState() => _ShowContaState();
}

class _ShowContaState extends State<ShowConta> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: widget.conta.length,
        itemBuilder: (context, index) {
          Conta c = widget.conta[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    c.prato,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text("R\$" + c.valor),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                            child: const Text('Delete'),
                            onPressed: () => _delete(c)),
                        FlatButton(
                          child: const Text('BUTTON'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
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

  void _delete(Conta c) {
    var db = Firestore.instance
        .collection("Mesas")
        .document(Mesa.id)
        .collection("Pedidos");

    Conta.quantidade --;

    Firestore.instance
        .collection("Mesas")
        .document(Mesa.id)
        .collection("Pedidos")
        .document(Conta.pratoId)
        .updateData({"quantidade": Conta.quantidade});
    print(Conta.quantidade);
  }
}
