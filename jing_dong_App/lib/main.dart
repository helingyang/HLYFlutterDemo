import 'package:flutter/material.dart';
import 'routes/router.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home:Tabs() ,
        initialRoute: '/',
        onGenerateRoute:onGenerateRoute
    );
  }
}