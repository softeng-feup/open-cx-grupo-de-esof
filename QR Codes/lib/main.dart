import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";
  final snackBar = new SnackBar(
    content: new Text("Texto copiado com sucesso!"),
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          key: this._scaffoldKey,
          appBar: new AppBar(
            backgroundColor: Colors.white,
            title: new Text('Leitor QRCODE',
              style: TextStyle(
                  color: Colors.black,
              ),
            ),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Divider(),
                new Container(
                  margin: const EdgeInsets.only(top: 150.0),
                  width: 330.0,
                  height: 60.0,
                  child: new RaisedButton(
                    color: Colors.black,
                    child: new Text(
                        'Scan',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40)
                    ),
                    onPressed: () {
                      scan();
                    },
                  ),
                ),
                new TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                  textAlign: TextAlign.center,
                  controller: new TextEditingController.fromValue(
                      new TextEditingValue(text: barcode)),
                  decoration: new InputDecoration(
                    hintText: 'aqui ficará o código encontrado.',
                    labelStyle: Theme.of(context).textTheme.display1,
                    contentPadding: new EdgeInsets.all(8.0),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Usuário não concedeu permissão para a câmera';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = '(Não foi possível ler o código)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
