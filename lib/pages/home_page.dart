import 'package:flutter/material.dart';
import 'package:projeto_restaurante/drawer_list.dart';
import 'package:projeto_restaurante/pages/pratos/lista_pratos.dart';

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
          title: Text("Carros1"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Entrada",
              ),
              Tab(
                text: "Sobremesa",
              ),
              Tab(
                text: "Bebidas",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListaPratos("Entrada"),
            ListaPratos("Sobremesa"),
            ListaPratos("Bebidas")
          ],
        ),
        drawer: DrawerList(),
      ),
    );
  }
}
