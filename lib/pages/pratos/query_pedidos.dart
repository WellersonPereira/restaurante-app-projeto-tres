import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/pages/pratos/show_pedidos.dart';

class QueryPedidos extends StatefulWidget {
  @override
  _QueryPedidosState createState() => _QueryPedidosState();
}

class _QueryPedidosState extends State<QueryPedidos> {
  var db = Firestore.instance.collectionGroup("Pedidos");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.where("status", isEqualTo: "Em preparo").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Conta> contas = snapshot.data.documents.map((document) {
            return Conta.fromJson(document.data);
          }).toList();
          return ShowPedidos.conta(contas);
        } else if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        {
          return Center(
            child: Text("sem dados"),
          );
        }
      },
    );
  }
}
