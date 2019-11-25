import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_restaurante/Model/usuario.dart';
import 'package:projeto_restaurante/firebase/firebase_service.dart';
import 'package:projeto_restaurante/pages/login/login_page.dart';
import 'package:projeto_restaurante/pages/pratos/query_pedidos.dart';
import 'package:projeto_restaurante/utils/nav.dart';

class DrawerList extends StatefulWidget {
  bool admin;
  DrawerList({this.admin});

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  UserAccountsDrawerHeader _header(FirebaseUser user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.displayName ?? ""),
      accountEmail: Text(user.email),
      currentAccountPicture: user.photoUrl != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
            )
          : Image.asset('assets/images/user.png'),
    );

  }
@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<FirebaseUser>(
              future: future,
              builder: (context, snapshot) {
                FirebaseUser user = snapshot.data;
                return user != null ? _header(user) : Container();
              },
            ),
            ListTile(
                leading: Icon(Icons.attach_money),
                title: Text("Conta"),
                subtitle: Text("mais informações..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () =>{} /*push(context, QueryConta())*/),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            ),
            _relatorio(context),
          ],
        ),
      ),
    );
  }

  _relatorio(context) {
    if (widget.admin == true) {
      return ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("Pedidos"),
        trailing: Icon(Icons.apps),
        onTap: () => push(context, QueryPedidos()));
    }
    else{
      return ListTile();
    }
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
