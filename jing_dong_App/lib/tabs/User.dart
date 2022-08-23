import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jing_dong_app/Views/JDButton.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';


late List<Widget> tabList;
late TabController _tabController;

class UserPage extends StatefulWidget {
  // UserPage({Key key}) : super(key: key);

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin {

  var tabbar;
  double appBarAlpha = 0;
  bool isHide = true;
  double appBarH = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // tabbar = HomePageTabBar();
    // // tabList = getTabList();
    // _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                double alpha = scrollNotification.metrics.pixels / 100;
                if (alpha < 0) {
                  alpha = 0;
                } else if (alpha > 1) {
                  alpha = 1;
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                }
                // setState(() => appBarAlpha = alpha);
                setState(() {
                  // appBarAlpha = alpha;
                  if(scrollNotification.metrics.pixels>100){
                    appBarAlpha = alpha;
                    // appBarH = 64;
                    isHide = false;
                    print("大于100了");
                  }else{
                    print("小于100了");
                    appBarAlpha = 0;
                    // appBarH = 0;
                    isHide = true;
                  }
                  print(scrollNotification.metrics.pixels);
                });
              }
              return true;
            },
            child: Container(
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [
              //       Color.fromARGB(255, 230, 86, 85),
              //       Color.fromARGB(255, 88, 103, 239),
              //     ],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //   ),
              // ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 228)
              ),
              padding: EdgeInsets.only(left: 8,right: 8),
              child: hlyCustomScrollView(),
            ),
          ),
        ),
        Offstage(
          offstage: isHide,
          child:Opacity(
            opacity: appBarAlpha,
            child:Container(
              // height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
              height: 64,
              decoration: BoxDecoration(
                color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: appBarAlpha == 1.0 ? Colors.black12 : Colors.transparent,
                    offset: Offset(2, 3),
                    blurRadius: 6,
                    spreadRadius: 0.6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      // children: [
                      //   Text("原价"),
                      //   Text("¥50",style: TextStyle(
                      //       color: Colors.black38,
                      //       fontSize: ScreeAdaper.size(28),
                      //       decoration: TextDecoration.lineThrough
                      //   ),)
                      // ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text("天才哈士奇",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,backgroundColor: Colors.white))
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          print("客服被点击");
                        }, icon: Icon(Icons.headset_mic)),
                        IconButton(onPressed: (){
                          print("setting被点击");
                        }, icon: Icon(Icons.settings_outlined)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }


  _myOnStretchTrigger() {
    print("被点击");
  }


}


class hlyCustomScrollView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(

      physics: BouncingScrollPhysics(),
      shrinkWrap: false,
      slivers: [
        // SliverAppBar(
        //   expandedHeight: 200,
        //   flexibleSpace: Image.network("https://www.itying.com/images/flutter/p1.jpg"),
        // ),
        SliverToBoxAdapter(
          child:Row(
              children: [
                Padding(padding: EdgeInsets.only(top: 16,left: 8,right: 8,bottom: 8),
                    child: ClipOval(
                      child: Image.network(
                        "http://pic.qbaobei.com/UploadFiles/shtk/2013/5/201305211450019391.jpg",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("天才哈士奇",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Padding(padding: EdgeInsets.only(top: 5),child: InkWell(
                      onTap: (){
                        print("圈子被点击");
                      },
                      child: Row(
                        children: [
                          Image.asset("assets/images/libaoS@2x.png",width: 15,height: 15,),
                          const Text("圈子"),
                          Padding(padding: EdgeInsets.only(left: 4,right: 4),
                            child: Container(
                              width: 1.0,
                              height: 10.0,
                              color: Colors.black38,
                            ),
                          ),
                          Text("更改了动态"),
                          Padding(padding: EdgeInsets.all(5),child: ClipOval(child: Container(
                            color: Colors.red,
                            width: 10,
                            height: 10,
                          ),),),
                          Image.asset("assets/images/xiangyouhei@2x.png",width: 15,height: 15,),
                        ],
                      ),
                    ),
                    )
                  ],
                ),
                Expanded(child: Container(),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      IconButton(onPressed: (){
                        print("客服被点击");
                      }, icon: Icon(Icons.headset_mic)),
                      Text("客服")
                    ],),
                    Column(children: [
                      IconButton(onPressed: (){
                        print("setting被点击");
                      }, icon: Icon(Icons.settings_outlined)),
                      Text("设置")
                    ],),
                  ],
                ),
              ],
            ),
        ),
        SliverToBoxAdapter(
          child: Card(
            // clipBehavior: Clip.antiAlias,
            // elevation: 1.0,
            // shadowColor: Colors.red,
            margin: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("我的称号",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Padding(padding: EdgeInsets.only(left: 8,right: 8),
                  child: Image.asset("assets/images/shenfenrenzheng@3x.png",width: 66,height: 20,),),
                  Expanded(child: Text("")),
                  Row(children: [
                    Image.asset("assets/images/xuanfuqiu_ico@3x.png",width: 25,height: 20,),
                    Image.asset("assets/images/xuanfuqiu_ico@3x.png",width: 25,height: 20,),
                    Image.asset("assets/images/xuanfuqiu_ico@3x.png",width: 25,height: 20,),
                    Image.asset("assets/images/xiangyouhei@2x.png",width: 15,height: 12,)
                  ],),
                ],
              ),
            ),

          )
        ),
        SliverToBoxAdapter(
          child: Container(
            // color: Colors.orange,
            // padding: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            margin: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                style: BorderStyle.solid,
                color: Color.fromARGB(255, 255, 225, 216),
              ),
              color: Colors.white
            ),
            child:Padding(padding: EdgeInsets.all(1),child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  // border: Border.all(
                  //   width: 1,
                  //   style: BorderStyle.solid,
                  //   color: Colors.orange,
                  // ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 213, 196),
                      Color.fromARGB(255, 255, 241, 233),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  // color: Color.fromARGB(255, 255, 221, 209)
              ),
              child: Row(
                children: [
                  // Text("我的称号",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Padding(padding: EdgeInsets.only(left: 8,right: 18),
                    child: Image.asset("assets/images/teshengbao.png",width: 56,height: 20,),),
                  Text("你有32元红包待领取",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                  Expanded(child: Text("")),
                  Container(
                    height: 40,
                    width: 88,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: JdButton(
                      bgColor: Color.fromRGBO(253, 1, 0, 0.9),
                      buttonText: "点击领取",
                      onClick: () {
                        print("点击领取按钮");
                      },
                    ),
                  ),
                ],
              ),
            ),),
          )
        ),

        // _divider(),
        // 我的订单
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            // height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("我的订单",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Expanded(child: Text("")),
                      InkWell(
                        child: Row(
                          children: [
                            Text("全部",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,color: Colors.black38),),
                            Image.asset("assets/images/xiangyouhei@2x.png",width: 15,height: 12,)
                          ],
                        ),
                        onTap: (){
                          print("全部按钮被点击");
                        },
                      )
                    ],
                  ),
                  Container(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: ScreeAdaper.width(40),
                                height: ScreeAdaper.height(40),
                                // color: Colors.green,
                                child: Image.asset(
                                  "assets/images/daifukuan.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: 70,
                                padding: EdgeInsets.only(top: 8, bottom: 12),
                                child: Text(
                                  "待付款",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreeAdaper.size(28),
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          print("代付款被点击");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: ScreeAdaper.width(40),
                                height: ScreeAdaper.height(40),
                                // color: Colors.green,
                                child: Image.asset(
                                  "assets/images/daifukuan.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: 70,
                                padding: EdgeInsets.only(top: 8, bottom: 12),
                                child: Text(
                                  "待发货",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreeAdaper.size(28),
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          print("待发货被点击");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: ScreeAdaper.width(40),
                                height: ScreeAdaper.height(40),
                                // color: Colors.green,
                                child: Image.asset(
                                  "assets/images/daifukuan.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: 70,
                                padding: EdgeInsets.only(top: 8, bottom: 12),
                                child: Text(
                                  "待收货",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreeAdaper.size(28),
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          print("待收货被点击");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: ScreeAdaper.width(40),
                                height: ScreeAdaper.height(40),
                                // color: Colors.green,
                                child: Image.asset(
                                  "assets/images/daifukuan.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: 70,
                                padding: EdgeInsets.only(top: 8, bottom: 12),
                                child: Text(
                                  "评价",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreeAdaper.size(28),
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          print("评价被点击");
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: ScreeAdaper.width(40),
                                height: ScreeAdaper.height(40),
                                // color: Colors.green,
                                child: Image.asset(
                                  "assets/images/daifukuan.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                width: 70,
                                padding: EdgeInsets.only(top: 8, bottom: 12),
                                child: Text(
                                  "退款售后",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreeAdaper.size(28),
                                    color: Color(0xFF3B3B3B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          print("退款售后被点击");
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:Color.fromARGB(255, 245, 245, 245),
                    ),
                    // margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 8,right: 8),
                          child: Image.asset("assets/images/xin.gif",width: 26,height: 26,),),
                        Text("好友跟买得2.6元现金"),
                        Expanded(child: Text("")),
                        GestureDetector(
                          onTap: (){
                            print("去分享");
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 12,right: 12,top: 3,bottom: 3),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1.2, color: Color.fromARGB(255, 215, 50, 50)),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "去分享",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 195, 18, 21),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // 收藏
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            // height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: ScreeAdaper.width(40),
                            height: ScreeAdaper.height(40),
                            // color: Colors.green,
                            child: Image.asset(
                              "assets/images/daifukuan.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: 70,
                            padding: EdgeInsets.only(top: 8, bottom: 0),
                            child: Text(
                              "收藏",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreeAdaper.size(28),
                                color: Color(0xFF3B3B3B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      print("收藏被点击");
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: ScreeAdaper.width(40),
                            height: ScreeAdaper.height(40),
                            // color: Colors.green,
                            child: Image.asset(
                              "assets/images/daifukuan.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: 70,
                            padding: EdgeInsets.only(top: 8, bottom: 0),
                            child: Text(
                              "关注店铺",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreeAdaper.size(28),
                                color: Color(0xFF3B3B3B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      print("关注店铺被点击");
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: ScreeAdaper.width(40),
                            height: ScreeAdaper.height(40),
                            // color: Colors.green,
                            child: Image.asset(
                              "assets/images/daifukuan.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: 70,
                            padding: EdgeInsets.only(top: 8, bottom: 0),
                            child: Text(
                              "红包",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreeAdaper.size(28),
                                color: Color(0xFF3B3B3B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      print("红包被点击");
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: ScreeAdaper.width(40),
                            height: ScreeAdaper.height(40),
                            // color: Colors.green,
                            child: Image.asset(
                              "assets/images/daifukuan.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: 70,
                            padding: EdgeInsets.only(top: 8, bottom: 0),
                            child: Text(
                              "优惠券",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreeAdaper.size(28),
                                color: Color(0xFF3B3B3B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      print("优惠券被点击");
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: ScreeAdaper.width(40),
                            height: ScreeAdaper.height(40),
                            // color: Colors.green,
                            child: Image.asset(
                              "assets/images/daifukuan.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: 70,
                            padding: EdgeInsets.only(top: 8, bottom: 0),
                            child: Text(
                              "历史浏览",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreeAdaper.size(28),
                                color: Color(0xFF3B3B3B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      print("历史浏览被点击");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        // _divider(),
        //我的零钱
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            // height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("我的零钱",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Padding(padding: EdgeInsets.only(left: 8,right: 3),
                    child: Image.asset("assets/images/coin.png",width: 16,height: 16,),),
                  Expanded(child: Text("¥0.00",textAlign: TextAlign.left,style: TextStyle(color: Colors.black45),),),
                  Row(children: [
                    // Image.asset("assets/images/xuanfuqiu_ico@3x.png",width: 25,height: 20,),
                    // Image.asset("assets/images/xuanfuqiu_ico@3x.png",width: 25,height: 20,),
                    // Image.asset("assets/images/xuanfuqiu_ico@3x.png",width: 25,height: 20,),
                    Image.asset("assets/images/xiangyouhei@2x.png",width: 15,height: 12,)
                  ],),
                ],
              ),
            ),
          ),
        ),
        // 品牌折扣周
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            clipBehavior: Clip.hardEdge,
            // height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 193, 222),
                        Color.fromARGB(255, 244, 236, 242),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    // color: Color.fromARGB(255, 255, 221, 209)
                  ),
                ),
                Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text("品牌折扣周",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                color: Colors.purpleAccent),),
                            Text(" 7.11-7.13",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,
                                color: Colors.purpleAccent),),
                            Expanded(child: Text("")),
                            InkWell(
                              child: Row(
                                children: [
                                  Text("领福利",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,color: Color.fromARGB(255, 195, 0, 0)),),
                                  Image.asset("assets/images/xiangyouhei@2x.png",width: 15,height: 12,)
                                ],
                              ),
                              onTap: (){
                                print("全部按钮被点击");
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: ScreeAdaper.width(84),
                                    height: ScreeAdaper.height(84),
                                    // color: Colors.green,
                                    child: Image.network("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fnewsimages.b2b.biz%2Fnews%2F0%2F479%2F872%2F61e5bea72aa3.jpg&refer=http%3A%2F%2Fnewsimages.b2b.biz&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1660470468&t=658a9dd47355818dd42f5861de4a75a9")
                                  ),
                                  Container(
                                    width: 70,
                                    padding: EdgeInsets.only(top: 8, bottom: 0),
                                    child: Text(
                                      "五金工具",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 231, 58, 42),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              print("五金工具被点击");
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: ScreeAdaper.width(84),
                                    height: ScreeAdaper.height(84),
                                    // color: Colors.green,
                                    child: Image.asset(
                                      "assets/images/chaju.gif",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    padding: EdgeInsets.only(top: 8, bottom: 0),
                                    child: Text(
                                      "茶具精选",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 231, 58, 42),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              print("茶具精选被点击");
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: ScreeAdaper.width(84),
                                    height: ScreeAdaper.height(84),
                                    // color: Colors.green,
                                    child: Image.network("https://img14.360buyimg.com/pop/jfs/t1/211833/22/10734/61146/61de4fe5E638daa8f/d64ac1eb6082d626.jpg")
                                  ),
                                  Container(
                                    width: 70,
                                    padding: EdgeInsets.only(top: 8, bottom: 0),
                                    child: Text(
                                      "试用中心",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 231, 58, 42),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              print("试用中心被点击");
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: ScreeAdaper.width(84),
                                    height: ScreeAdaper.height(84),
                                    // color: Colors.green,
                                    child: Image.network("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Fart_origin_min_pic%2F19%2F03%2F20%2F447e9a0ee30ae05cd250c2aff7646f3a.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1660470796&t=557728f5c29fe2a212db4baa9414ce0c")
                                  ),
                                  Container(
                                    width: 70,
                                    padding: EdgeInsets.only(top: 8, bottom: 0),
                                    child: Text(
                                      "低至五折",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 231, 58, 42),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              print("低至五折被点击");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )

          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              '暂无新提醒',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        _divider(),
        SliverToBoxAdapter(
          child: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              '暂无新提醒',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        _divider(),
        SliverToBoxAdapter(
          child: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              '暂无新提醒',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        _divider(),
        SliverToBoxAdapter(
          child: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              '暂无新提醒',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        _divider(),
        SliverToBoxAdapter(
          child: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: Text(
              '暂无新提醒',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        _divider(),
        SliverToBoxAdapter(
          child:Card(
            elevation:1.0,
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.network(
                    "http://file03.16sucai.com/2016/06/20165rd2yvmc025.jpg",
                    fit: BoxFit.cover,
                  ),
                  margin: EdgeInsets.all(10),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://pic.qbaobei.com/UploadFiles/shtk/2013/5/201305211450019391.jpg"
                    ),
                  ),
                  title: Text("Candy Shop"),
                  subtitle: Text(
                    "Flutter is Goole's moblie UI framework for crafting higt ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }

  SliverToBoxAdapter _divider() {
    return SliverToBoxAdapter(
      child: Container(
        height: 10.0,
        color: const Color.fromARGB(255, 247, 247, 247),
      ),
    );
  }

}

// http://pic.qbaobei.com/UploadFiles/shtk/2013/5/201305211450019391.jpg









