import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/pages/pratos/pratos_listview.dart';

class ListaPratos extends StatefulWidget {
  String tipo;
  ListaPratos(this.tipo);

  @override
  _ListaPratosState createState() => _ListaPratosState();
}
class _ListaPratosState extends State<ListaPratos> with AutomaticKeepAliveClientMixin {

  String get tipo => widget.tipo;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Pratos").where("tipo", isEqualTo: tipo).where("disponivel", isEqualTo: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Prato> pratos =
              snapshot.data.documents.map((document) {
            return Prato.fromJson(document.data);
          }).toList();
          return PratoListView(pratos);
        } else if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        {
          return Center(
            child: Text("Sem dados"),
          );
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
