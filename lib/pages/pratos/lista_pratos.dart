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
      child: ListView.builder(
        itemCount: widget.pratos.length,
        itemBuilder: (context, index) {
          Prato p = widget.pratos[index];
          return GestureDetector(
            onTap: () => _onClickPrato(context, p),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      p.urlFoto,
                    ),
                    Text(
                      p.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      color: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "R\$" + p.valor,
                            textAlign: TextAlign.left,
                          )
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

  _onClickPrato(BuildContext context, Prato p) {
    push(context, PratoPage(prato: p));
  }

}
