import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/pages/pratos_listview.dart';

class ListaPratos extends StatefulWidget {
  //Prato prato;
  //PratosPage(this.prato);

  @override
  _ListaPratosState createState() => _ListaPratosState();
}
//TODO:Criar uma colection para cada tipo de prato e fazer com que uma String receba-a. Ex "Entrada" invês de "Comida"

class _ListaPratosState extends State<ListaPratos> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('comida').snapshots(),
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
}
