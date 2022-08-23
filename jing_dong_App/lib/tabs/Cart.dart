import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CartPage extends StatefulWidget {
  // CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
    @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),

      ///越界回弹效果
      slivers: [
        CupertinoSliverRefreshControl(
          refreshIndicatorExtent: 60,
          /// 刷新过程中悬浮高度
          refreshTriggerPullDistance: 100,
          ///触发刷新的距离
          /// 自定义布局
          builder: (context, buildRefreshindictor, pulledExtent,
              refreshTriggerPullDistance, refreshIndicatorExtent) {
            // printString(
            //     'pulledExtent : ${pulledExtent}   ,refreshTriggerPullDistance  : ${refreshTriggerPullDistance}    refreshIndicatorExtent:${refreshIndicatorExtent}');
            return Container(
              color: Colors.redAccent,
              height: 150,
              alignment: Alignment.center,
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  //opacity: top == 80.0 ? 1.0 : 0.0,
                  opacity: 1.0,
                  child: Text(
                    RefreshIndicatorMode.done == buildRefreshindictor
                        ? '已拉动:${pulledExtent.round()}  松开刷新'
                        : '已拉动:${pulledExtent.round()}  下拉刷新',
                    style: TextStyle(fontSize: 12.0),
                  )),
            );
          },

          ///触发刷新回调
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 3));
            // printString('CupertinoSliverRefreshControl   onRefresh');

          },
        ),

        SliverAppBar(
          centerTitle: true,
          titleSpacing: 0,
          title: Text(
            'CustomScrollView',
            style: TextStyle(color: Colors.black87),
          ),

          /// 停止拖动是否 继续响应拖动事件
          snap: false,

          /// 下滑过程中是否优先展开头部折叠部分 ,
          floating: false,

          ///pinned(固定的)  控制隐藏和展示的   false 就是可以随列表滑出屏幕外  true 不可以
          pinned: true,
          backgroundColor: Colors.blueAccent,
          expandedHeight: 200,///展开后的高度
          flexibleSpace: LayoutBuilder(
            builder: (context, cons) {
              return FlexibleSpaceBar(
//              collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/hor.jpg'), fit: BoxFit.fill),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '这个是头部',
                          style: TextStyle(color: Colors.pink),
                        ),
                        Text(
                          '这个是头部',
                          style: TextStyle(color: Colors.pink),
                        ),
                        Text(
                          '这个是头部',
                          style: TextStyle(color: Colors.pink),
                        ),
                        Text(
                          '这个是头部',
                          style: TextStyle(color: Colors.pink),
                        ),
                        Text(
                          '这个是头部',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ),
//
        SliverPersistentHeader(
          floating: true,
          pinned: false,
          delegate: _SliverPersistenHeaderDelegate(
              minHeight: 50, maxHeight: 150, child: Text('1111')),
        ),
        SliverSafeArea(
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                    height: 50,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    child: Center(
                      child: Text(index.toString()),
                    ),
                  ),
                  childCount: 50)),
        )
      ],

      // slivers: [
      //   SliverAppBar(
      //     title: Text("天才哈士奇"),
      //     expandedHeight: ScreeAdaper.height(300),
      //     collapsedHeight: ScreeAdaper.height(120),
      //     floating: false,
      //     pinned: true,
      //     snap: false,
      //     stretch: true,
      //     stretchTriggerOffset: 64,
      //     onStretchTrigger: (){
      //       return _myOnStretchTrigger();
      //     },
      //     flexibleSpace: FlexibleSpaceBar(
      //       title: Text("tiancaihashiqi",textAlign: TextAlign.right,style: TextStyle(color: Colors.white),),
      //       background: Container(
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             fit: BoxFit.cover,
      //             image: NetworkImage("https://lmg.jj20.com/up/allimg/tp05/19100215021554I-0-lp.jpg"),
      //           ),
      //         ),
      //         child: Text("dsagsagsafsdafsa"),
      //       ),
      //       centerTitle: true,
      //       titlePadding: EdgeInsets.all(0),
      //       collapseMode: CollapseMode.parallax,
      //       stretchModes: [
      //         StretchMode.zoomBackground,
      //         StretchMode.blurBackground,
      //         StretchMode.fadeTitle,
      //       ],
      //     ),
      //   ),
      //   SliverList(delegate: SliverChildBuilderDelegate(
      //       (BuildContext context, int index){
      //         return Container(
      //           height: 50,
      //           color: Colors.primaries[(index % 10)],
      //         );
      //       },
      //     childCount: 30,
      //   )),
      // ],
    );
  }
}






class _SliverPersistenHeaderDelegate extends SliverPersistentHeaderDelegate {
  double maxHeight;
  double minHeight;
  Widget child;

  _SliverPersistenHeaderDelegate({required this.maxHeight, required this.minHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => max<double>(minHeight, maxHeight);

  @override
  // TODO: implement minExtent
  double get minExtent => min<double>(minHeight, maxHeight);

  @override
  bool shouldRebuild(_SliverPersistenHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}













