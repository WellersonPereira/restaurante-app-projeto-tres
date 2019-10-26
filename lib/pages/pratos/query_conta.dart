import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/model/conta.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/pages/pratos/show_conta.dart';

class QueryConta extends StatefulWidget {
  @override
  _QueryContaState createState() => _QueryContaState();
}

class _QueryContaState extends State<QueryConta> {
  var local = Firestore.instance
      .collection("Mesas")
      .document(Mesa.id)
      .collection("Pedidos");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: local.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Conta> contas = snapshot.data.documents.map((document) {
            return Conta.fromJson(document.data);
          }).toList();
          return ShowConta.conta(contas);
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
