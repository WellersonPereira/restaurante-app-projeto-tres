import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/model/conta.dart';

class ShowConta extends StatelessWidget {
  final List<Conta> conta;
  ShowConta.conta(this.conta);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: conta.length,
        itemBuilder: (context, index) {
          Conta c = conta[index];
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
                          onPressed: _delete
                        ),
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

  void _delete() {

    Firestore.instance.collection("Mesas").document("002").collection("Pedidos").document().delete();
    print(Firestore.instance.collection("Mesas").document("002").collection("Pedidos").document().documentID);
  }
}
