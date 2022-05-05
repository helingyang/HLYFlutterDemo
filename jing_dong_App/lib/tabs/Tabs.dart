import 'package:flutter/material.dart';

import 'Home.dart';
import 'Cart.dart';
import 'Category.dart';
import 'User.dart';

class Tabs extends StatefulWidget {
  // Tabs({Key key}) : super(key: key);

  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex=0;
  List _pageList=[
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('jdshop'),
        ),

        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap:(index){
            this.setState((){
              this._currentIndex=index;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '购物车'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的')
          ],
        ),
      ),
    );
  }
}