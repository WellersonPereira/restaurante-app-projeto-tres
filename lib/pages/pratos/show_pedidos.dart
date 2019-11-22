import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/bg_login.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/utils/alert.dart';
import 'package:toast/toast.dart';

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
          return GestureDetector(
            child: Card(
              color: Color.fromRGBO(204, 255, 51, 85),
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
                    Text("Qtd: " + c.qtd.toString()),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                              child: const Text('Update'),
                              onPressed: () => _update(c)),
                          FlatButton(
                              child: const Text('Detalhes'),
                              onPressed: () => _detalhes(c))
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
    //alert(context, "Pedido encaminhado para o cliente");
    Toast.show("Pedido encaminhado para o cliente", context,
        duration: Toast.LENGTH_LONG);
  }

  _detalhes(Conta c) {
    //Todo: mostrar pop-out com detalhes do pedido.
    alert(
        context,
        "Prato: ${c.prato} \n\n"
        "Quantidade: ${c.qtd}\n\n"
        "Detalhes: ${c.desc}");
  }
}
