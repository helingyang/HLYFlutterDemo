import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/ScreenAdaper.dart';
import 'Home.dart';
import 'Cart.dart';
import 'Category.dart';
import 'User.dart';

class Tabs extends StatefulWidget {
  // Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int _currentIndex=0;

  late final PageController _pageController = PageController(initialPage: _currentIndex);

  void initStatus(){
    super.initState();
    // _pageController = new PageController(initialPage: _currentIndex);
  }

  final List<Widget> _pageList=[
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
          // title: Text('hly京东app'),
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),

        // body: this._pageList[this._currentIndex],//点击跳转的
        body: PageView(//滑动跳转的
          controller: _pageController,
          children: _pageList,
          onPageChanged:(index){
            print("跳转到第$index 页面,做tabbar切换");
            setState(() {
              this._currentIndex=index;
            });
          },
        ),


        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap:(index){
            setState((){
              _currentIndex=index;
              _pageController.jumpToPage(_currentIndex);
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          items: const [
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