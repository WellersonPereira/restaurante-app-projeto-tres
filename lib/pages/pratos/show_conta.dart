import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/bg_login.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:toast/toast.dart';

class ShowConta extends StatefulWidget {
  List<Conta> conta;

  ShowConta.conta(this.conta);

  @override
  _ShowContaState createState() => _ShowContaState();
}

class _ShowContaState extends State<ShowConta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conta"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[BgLogin(), _body()],
      ),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: widget.conta.length,
        itemBuilder: (context, index) {
          Conta c = widget.conta[index];
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                        child: Text(
                          c.prato,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(
                          "Unid R\$ " + c.valor,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Qtd: " + c.qtd.toString(),
//                          "Unidade R\$ " + c.valor,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "R\$ ${_valor(c)}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text("Status: " + c.status),
              ButtonTheme.bar(
                child: verificaStatus(c),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              )
            ],
          );
        },
      ),
    );
  }

  verificaStatus(Conta c) {
    if (c.status != "Aguardando confirmação") {
      return ButtonBar(
        children: <Widget>[
          FlatButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {}),
          FlatButton(
              child: const Text(
                'enviar',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {})
        ],
      );
    } else {
      return ButtonBar(
        children: <Widget>[
          FlatButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => _delete(c)),
          FlatButton(
              child: const Text(
                'enviar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => _enviar(c))
        ],
      );
    }
  }

  void _delete(Conta c) {
    c.qtd--;

    Firestore.instance
        .collection("Mesas")
        .document(c.mesa)
        .collection("Pedidos")
        .document(c.pedidoId)
        .updateData({'quantidade': c.qtd});
    print(c.qtd);
  }

  _enviar(Conta c) {
    Firestore.instance
        .collection("Mesas")
        .document(c.mesa)
        .collection("Pedidos")
        .document(c.pedidoId)
        .updateData({'status': "Em preparo"});
    //TODO: Atualizar o valot total das compras.
    Toast.show("Seu pedido foi encaminhado para a cozinha", context,
        duration: Toast.LENGTH_LONG);
  }

  _valor(Conta c) {
    double valorTotal = c.qtd.toDouble() * double.parse(c.valor);
    c.total = valorTotal;
    return valorTotal;
  }
}
