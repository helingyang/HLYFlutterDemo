import 'package:flutter/material.dart';
// import 'package:flutter_jdshop/services/ScrenAdaper.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';
class SearchPage extends StatefulWidget {

  // SearchPage({required Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                  )
              ),
            ),
            height: ScreeAdaper.height(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233,233,233,0.8),
                borderRadius: BorderRadius.circular(30)
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: ScreeAdaper.height(68),
                width: ScreeAdaper.width(80),
                child: Row(
                  children: <Widget>[
                    Text('搜索')
                  ],
                ),
              ),
              onTap: (){

              },
            )
          ],
        ),
        body: Text('搜索')
    );
  }
}