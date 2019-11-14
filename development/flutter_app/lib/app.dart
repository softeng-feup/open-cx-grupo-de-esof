

import 'package:flutter/material.dart';
import 'homePage/HomePage.dart';
import 'homePage/Page1.dart';

const HomePage1path = '/';
const HomePage2path = '/second';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //onGenerateRoute: _routes(),
      initialRoute: HomePage.routeName,

      routes: <String, WidgetBuilder> {
        HomePage.routeName: (context) => HomePage(),
        Page1.routeName: (context) => Page1(),
      }

    );
  }

  /*
  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case HomePage1path:
          print('hello page 1');
          screen = HomePage1();
          break;
        case HomePage2path:
          print('hello page 2');
          screen = HomePage2();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
  */

}