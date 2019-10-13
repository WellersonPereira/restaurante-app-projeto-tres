import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_restaurante/pages/home_page.dart';
import 'package:projeto_restaurante/utils/nav.dart';

class QrScan extends StatefulWidget {
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String _barcode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leitura QrCode"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/barcode.png',
              height: 150,
            ),
            SizedBox(
              height: 20,
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
      ),
      drawer: Drawer(),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      final mesa = int.parse(barcode);
      if (mesa > 0 && mesa <= 5) {
        setState(() => this._barcode = barcode);

        final user = await FirebaseAuth.instance.currentUser();
        final nome = user.uid;

        //Salva a mesa e o cliente no banco de dados;
        Firestore.instance
            .collection("Mesa" + barcode)
            .document()
            .setData({"nome": nome, "ocupada": true});

        push(context, HomePage(), replace: true);
      }
      else{
        this._barcode = "Qr code inválido";
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._barcode = 'O usuário não deu permissão para o uso da camera';
        });
      } else {
        setState(() => this._barcode = 'Error desconocido $e');
      }
    } on FormatException {
      setState(() => this._barcode =
          'nulo, o usuário pressionou o botão voltar antes de scannear)');
    } catch (e) {
      setState(() => this._barcode = 'Error desconocido : $e');
    }
  }
}
