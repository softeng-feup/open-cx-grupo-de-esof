import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Data/quizz.dart';
import 'dart:async';
import 'AnswerQuiz.dart';
import 'HomePage.dart';
import '../app.dart';

class StandCodePage extends StatelessWidget {
  static const String routeName = '/standcodepage';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stand Code',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stand Code'),
        ),
        body: Center(
            child: Column(children: <Widget>[
              SizedBox(height: 10),
              Title(),
              SizedBox(height: 10),
              StandCodeTextField(),
              SizedBox(height: 50),
              AdviceText(),
              SizedBox(height: 50),
              ScanQR_button(),
            ])
      ),
    )
    );
  }
}

class AdviceText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
       "You can also access the quiz by scanning a QR Code",
      style: TextStyle(
          fontSize: 20,
        ),
      textAlign: TextAlign.center,
    );
  }
}

class StandCodeTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Insert here the stand code',
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Stand Code",
      style: TextStyle(
        fontSize: 40,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class ScanQR_button extends StatefulWidget {
  @override
  _ScanQR_state createState() => new _ScanQR_state();
}

class _ScanQR_state extends State<ScanQR_button> {
  String barcode = "";
  final snackBar = new SnackBar(
    content: new Text("Texto copiado com sucesso!"),
  );
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.black,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blue,
      onPressed: () {
        scan();
        var questions = [["question1", "answer1", "answer2", "answer3"], ["question2", "answer1", "answer2", "answer3"], ["question3", "answer1", "answer2", "answer3"]];
        var correct = [0, 1, 2];
        var quiz = new Quiz.testCons(questions, correct);
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) =>
            new StartQuiz(quiz: quiz))
        );

      },
      child: RichText(
        text: TextSpan(
          text: 'Scan QR Code',
          style: TextStyle(
            color: Colors.white,
              ),
        ),
        textScaleFactor: 2,
      ),
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

/*

  _buttonTap(BuildContext context) {
    print("tapped!");

    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new QRcodePage())
    );
  }
  */
