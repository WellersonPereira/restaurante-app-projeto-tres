import 'package:flutter/material.dart';
import 'package:projeto_restaurante/bg_login.dart';
import 'package:projeto_restaurante/drawer_list.dart';
import 'package:projeto_restaurante/pages/pratos/admin_query_pratos.dart';
import 'package:projeto_restaurante/pages/pratos/query_conta.dart';
import 'package:projeto_restaurante/pages/pratos/query_pratos.dart';
import 'package:projeto_restaurante/utils/nav.dart';

class Cardapio extends StatefulWidget {
  final bool admin;

  Cardapio({this.admin});

  @override
  _CardapioState createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
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
                  text: "Principais",
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
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[BgLogin(), _ifAdmin()],
          ),
          drawer: DrawerList(
            admin: widget.admin,
          ),
          floatingActionButton: _ifBotao()
//        FloatingActionButton.extended(
//          icon: Icon(Icons.shopping_basket),
//          label: Text("Sacola"),
//          onPressed: () => push(context, QueryConta()),
//        ),
          ),
    );
  }

  _ifAdmin() {
    if (widget.admin == true) {
      return TabBarView(
        children: <Widget>[
          AdminQueryPratos("Entrada"),
          AdminQueryPratos("Sobremesa"),
          AdminQueryPratos("Bebidas")
        ],
      );
    } else if (widget.admin == false) {
      return TabBarView(
        children: <Widget>[
          QueryPratos("Entrada"),
          QueryPratos("Sobremesa"),
          QueryPratos("Bebidas")
        ],
      );
    }
  }

  _ifBotao() {
    if (widget.admin == true) {
      return null;
    } else if (widget.admin == false) {
      return FloatingActionButton.extended(
        icon: Icon(Icons.shopping_basket),
        label: Text("Sacola"),
        onPressed: () => push(context, QueryConta()),
      );
    }
  }
}
