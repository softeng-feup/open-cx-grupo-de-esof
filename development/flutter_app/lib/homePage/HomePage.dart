import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'Page1.dart';
import '../app.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
          child: MyButton(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _buttonTap(context, 1);
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.red,
        ),
        child: Center(
          child: Text('QR Code'),
        ),
      ),
    );
  }

  _buttonTap(BuildContext context, int arg) {
    print("tapped!");

    // Nao funciona, nao sei porque
    //Navigator.pushNamed(context, page1.routeName);

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new Page1())
    );


  }
}