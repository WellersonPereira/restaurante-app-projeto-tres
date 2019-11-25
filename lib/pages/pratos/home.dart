import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_restaurante/bg_login.dart';
import 'package:projeto_restaurante/drawer_list.dart';
import 'package:projeto_restaurante/model/mesa.dart';
import 'package:projeto_restaurante/pages/pratos/cardapio.dart';
import 'package:projeto_restaurante/utils/nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _barcode = "";
  FirebaseUser currentUser;
  bool admin;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text("Restaurante"),
//          centerTitle: true,
//        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[BgLogin(), StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("Clientes")
                .document(currentUser.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text("Carregando...");
                default:
                  return checkRole(snapshot.data);
              }
            },
          ),],
        ),
        drawer: DrawerList(
          admin: admin,
        ));
  }

  //Verifica o papel do usuário.
  checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data['role'] == 'admin') {
      admin = true;
      return adminPage(snapshot);
    } else {
      admin = false;
      return userPage(snapshot);
    }
  }

  userPage(DocumentSnapshot snapshot) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            'assets/images/QRCodeScanning.gif',
            height: 250,
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10.0),
            child: RaisedButton(
              color: Colors.amber,
              textColor: Colors.black,
              splashColor: Colors.blueGrey,
              onPressed: scan,
              child: const Text('Scannear QrCode'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              _barcode,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  adminPage(DocumentSnapshot snapshot) {
    return Cardapio(admin: true,);
//      Container(
//      child: FlatButton(
//        child: Text("cardapio"),
//        onPressed: () => push(context, Cardapio(admin: true,)),
//      ),
//    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      final mesa = int.parse(barcode);
      if (mesa > 0 && mesa <= 5) {
        setState(() => this._barcode = barcode);

        final user = await FirebaseAuth.instance.currentUser();
        final nomeUser = user.displayName;

        //Criando Id
        String hora = TimeOfDay.now().toString().substring(10, 15);
        String id = "$barcode$hora";

        //Salva a mesa e o cliente no banco de dados;
        Mesa.setId(id);
        Firestore.instance.collection("Mesas").document(Mesa.id).setData({
          "mesa": barcode,
          "cliente": nomeUser,
          "chegada": Timestamp.now(),
          "ocupada": true
        });

        push(context, Cardapio(admin: false,), replace: true);
      } else {
        this._barcode = "Qr code inválido";
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._barcode = 'O usuário não deu permissão para o uso da camera';
        });
      } else {
        setState(() => this._barcode = 'Error desconhecido $e');
      }
    } on FormatException {
      setState(() => this._barcode = 'Scaneamento interrompido');
    } catch (e) {
      setState(() => this._barcode = 'Error desconhecido : $e');
    }
  }
}
