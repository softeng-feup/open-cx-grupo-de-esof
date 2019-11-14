import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'homePage2.dart';
import '../app.dart';

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage1',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HomePage 1'),
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
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Engage'),
        ),
      ),
    );
  }

  _buttonTap(BuildContext context, int arg) {
    print("tapped!");
    Navigator.pushNamed(context, HomePage2path, arguments: {'id': arg});
  }
}