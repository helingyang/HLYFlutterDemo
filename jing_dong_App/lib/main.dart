import 'package:flutter/material.dart';
import 'package:jing_dong_app/tabs/Tabs.dart';
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
      home:Tabs() ,
      //   initialRoute: '/',
      //   initialRoute: '/productList',
        debugShowCheckedModeBanner: false,
        // initialRoute: '/search',
        onGenerateRoute:onGenerateRoute,
      theme: ThemeData(
          primaryColor: Colors.white
      ),
    );
  }
}