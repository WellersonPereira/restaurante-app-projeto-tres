import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/prato.dart';
import 'package:projeto_restaurante/pages/pratos/prato_page.dart';
import 'package:projeto_restaurante/utils/nav.dart';

class ListaPrato extends StatefulWidget {
  final List<Prato> pratos;

  ListaPrato.prato(this.pratos);

  @override
  _ListaPratoState createState() => _ListaPratoState();
}

class _ListaPratoState extends State<ListaPrato> {
  @override
  void initState() {
    // TODO: implement initState
    Prato.qtd = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: widget.pratos.length,
        itemBuilder: (context, index) {
          Prato p = widget.pratos[index];
          return GestureDetector(
            onTap: () => _onClickPrato(context, p),
            child: Card(
              color: Color.fromRGBO(204, 255, 51, 85),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInImage.assetNetwork(
                    placeholder: '',
                    image: p.urlFoto,
                    fit: BoxFit.cover,
                    width: 125.0,
                    height: 125.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //TODO:Fix layout
                      Text(p.nome, style: TextStyle(fontSize: 30),),
                      Text("R\$ " + p.valor, style: TextStyle(fontSize: 18,),)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickPrato(BuildContext context, Prato p) {
    push(context, PratoPage(prato: p));
  }
}
