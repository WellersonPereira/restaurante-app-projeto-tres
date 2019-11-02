import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/model/prato.dart';

class ShowPedidos extends StatefulWidget {
  List<Conta> conta;
  ShowPedidos.conta(this.conta);

  @override
  _ShowPedidosState createState() => _ShowPedidosState();
}

class _ShowPedidosState extends State<ShowPedidos> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conta"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: widget.conta.length,
        itemBuilder: (context, index) {
          Conta c = widget.conta[index];
          return GestureDetector(
            onTap: _detalhes(c),
            child: Card(
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
                    Text(c.qtd.toString()),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                              child: const Text('Update'),
                              onPressed: () => _update(c)),
                          FlatButton(
                              child: const Text('Detalhes'),
                              onPressed: () =>{})
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _update(Conta c) {
    c.status = "feito";
    Firestore.instance
        .collection("Mesas")
        .document(Mesa.id)
        .collection("Pedidos")
        .document(c.pedidoId)
        .updateData({'status': c.status, 'entregue': Timestamp.now()});
    //TODO: mandar notificação para o usuário
  }

  _detalhes(Conta c) {
    //Todo: mostrar pop-out com detalhes do pedido.
  }

//  _update(Conta c) {
//    c.status = "cozinhando";
//    Firestore.instance
//        .collection("Mesas")
//        .document(Mesa.id)
//        .collection("Pedidos")
//        .document(Conta.pratoId)
//        .updateData({'status': c.status});
//    print(c.qtd);
//  }

}
