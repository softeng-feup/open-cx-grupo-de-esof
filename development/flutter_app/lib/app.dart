
import 'package:flutter/material.dart';
import 'Pages/StandCodePage.dart';
import 'Pages/HomePage.dart';
import 'Pages/QRcodePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //onGenerateRoute: _routes(),
      initialRoute: HomePage.routeName,

      routes: <String, WidgetBuilder> {
        HomePage.routeName: (context) => HomePage(),
        StandCodePage.routeName: (context) => StandCodePage(),
        QRcodePage.routeName: (context) => QRcodePage(),
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