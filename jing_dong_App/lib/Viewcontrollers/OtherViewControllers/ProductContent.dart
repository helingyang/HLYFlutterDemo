



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jing_dong_app/Viewcontrollers/OtherViewControllers/ProductContent/ProductContent1.dart';
import 'package:jing_dong_app/Viewcontrollers/OtherViewControllers/ProductContent/ProductContent2.dart';
import 'package:jing_dong_app/Viewcontrollers/OtherViewControllers/ProductContent/ProductContent3.dart';
import 'package:jing_dong_app/Views/JDButton.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';

class ProductContentPage extends StatefulWidget{
  final Map argument;
  ProductContentPage(this.argument):super();

  _ProductContentPageState createState() => _ProductContentPageState();
}


class _ProductContentPageState extends State<ProductContentPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: AppBar(
        // title: const Text("hlyTabbar ViewController"),
        // bottom: const TabBar(tabs: [
        //   Tab(child: Text("商品"),),
        //   Tab(child: Text("详情"),),
        //   Tab(child: Text("评价"),),
        // ]),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreeAdaper.width(400),
              child: TabBar(
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(child: Text("商品"),),
                  Tab(child: Text("详情"),),
                  Tab(child: Text("评价"),),
                ],
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    ScreeAdaper.width(600), 76, 10, 0),
                items: [
                  PopupMenuItem(
                    child: Row(
                      children: <Widget>[Icon(Icons.home), Text('首页')],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: <Widget>[Icon(Icons.search), Text('搜索')],
                    ),
                  ),
                ]);
          }, icon: Icon(Icons.more_horiz))
        ],
      ),
      body: Stack(
        children: <Widget>[
          TabBarView(
            children: <Widget>[
              ProductContentFirst(),
              ProductContentSecond(),
              ProductContentThird(),
            ],
          ),
          Positioned(
            width: ScreeAdaper.width(750),
            height: ScreeAdaper.height(108),
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black54,width: 1)
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: ScreeAdaper.height(10)),
                    width: 100,
                    height: ScreeAdaper.height(88),
                    child: Column(
                      children: [
                        Icon(Icons.shopping_cart, size: 15,),
                        Text("购物车")
                      ],
                    ),
                  ),
                  Expanded(child: JdButton(
                    bgColor:Color.fromRGBO(253, 1, 0, 0.9),
                    buttonText: "加入购物车",
                    onClick: (){
                      print("加入购物车成功");
                    },
                  )),
                  Expanded(child: JdButton(
                    bgColor:Color.fromRGBO(255, 165, 0, 0.9),
                    buttonText: "立即购买",
                    onClick: () {
                      print("立即购买被点击");
                    },
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}