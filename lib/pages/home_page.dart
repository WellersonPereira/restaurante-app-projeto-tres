import 'package:flutter/material.dart';
import 'package:projeto_restaurante/drawer_list.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/pages/pratos/query_pratos.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Restaurante"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Entrada",
              ),
              Tab(
                text: "Sobremesa",
              ),
              Tab(
                text: "id",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            QueryPratos("Entrada"),
            QueryPratos("Sobremesa"),
            QueryPratos("Bebidas")
          ],
        ),
        drawer: DrawerList(),
      ),
    );
  }
}
