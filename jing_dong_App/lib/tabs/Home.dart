// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';

// import 'dart:convert';
import 'package:jing_dong_app/config/Config.dart';
import 'package:dio/dio.dart';

//轮播图类模型：
import '../../model/FocusModel.dart';

//热门推荐：
import '../../model/ProductModel.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];



  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),//轮播图

        SizedBox(height: ScreeAdaper.height(20)),
        _titleWidget("热门推荐"),
        _hotProductListWidget(),

        SizedBox(height: ScreeAdaper.height(20)),
        _titleWidget("猜你喜欢"),
        // 网络请求的猜你喜欢
        // _recProductListWidget()
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: <Widget>[
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget()
            ],
          ),
        )
      ],
    );
  }



  @override
  bool get wantKeepAlive => true;
  @override
  void initState(){
    super.initState();
    _getFocusData();
    _getHotPruductData();
    _getBestProductData();
  }
  //轮播的数据请求
  _getFocusData()async{
    var api = "${Config.domain}/api/focus";
    var result = await Dio().post(api);
    var focusList = FocusModel.fromJson(result.data);
    focusList.result.forEach((element) {
      print(element.title);
      print(element.pic);
    });

    setState(() {
      this._focusData = focusList.result;
    });

  }

//获取猜你喜欢的数据：
  _getHotPruductData()async{
    var api = "${Config.domain}api/plist?is_hot=1";
    var result = await Dio().get(api);
    var hotPrudocList = ProductModel.fromJson(result.data);
    setState(() {
      this._hotProductList = hotPrudocList.result;
    });

  }

//获取热门推荐的数据：
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }


  //轮播图：
  //flutter run -d all 链接多个设备的命令：
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"}
    ];
    // if(this._focusData.length>0){
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              //轮播请求，匹配下边注释代码 "${pic}",展示网络请求的数据
              // String pic = this._focusData[index].pic;
              // pic = Config.domain + pic.replaceAll("\\", "/");
              // "${pic}",
              return new Image.network(
                imgList[index]['url'],
                // fit: BoxFit.cover,
              );
            },
            // itemCount: this._focusData.length,
            itemCount: imgList.length,
            pagination: new SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  size: 8,
                  activeSize: 8,
                  color: Colors.white,
                  activeColor: Colors.deepOrange,
                )
            ),
            // control: new SwiperControl(color: Colors.pink),// 页面控制器 左右翻页按
            // 钮（不过基本都不会使用到，不使用直接设置null即可
            autoplay: true,
            scale: 0.75,// 动画时候的缩放
            scrollDirection: Axis.horizontal,//滚动方向
            duration: 1000,//滚动动画的时间间隔，单位毫秒
            itemWidth: 400,
            itemHeight: 260,
            layout: SwiperLayout.DEFAULT,// 设置轮播图展示样式（大家可以根据自己的需求自行设置）
            // 一共 { DEFAULT, STACK, TINDER, CUSTOM }四种模式
            onTap: (index) => print("点击了第$index个"),
          ),
        ),
      );
    // }else{
    //   return Text("加载中 ...");
    // }

  }

 
  // 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
  //标题：
  Widget _titleWidget(value) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(46),
      margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red,
                  width: ScreenUtil.getInstance().setWidth(10)))),
      child: Text(value, style: TextStyle(color: Colors.black54)),
    );
  }

  Widget _hotProductListWidget(){

    // if(this._hotProductList.length>0){
      return Container(
        height: ScreeAdaper.height(240),
        padding: EdgeInsets.all(ScreeAdaper.width(10)),
        child: ListView.builder(
          itemBuilder:(contxt,index){
            //热门商品通过数据请求 配合"${sPic}",显示图片
            // String sPic = this._hotProductList[index].sPic;
            // sPic = Config.domain + sPic.replaceAll('\\', '/');

            return Column(
              children: [
                Container(
                  height: ScreeAdaper.height(140),
                  width: ScreeAdaper.width(140),
                  margin: EdgeInsets.only(right: ScreeAdaper.width(21)),
                  child: Image.network(
                    'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                    // "${sPic}",
                    fit: BoxFit.cover,),

                ),
                Container(
                  padding: EdgeInsets.only(top: ScreeAdaper.height(10)),
                  height: ScreeAdaper.height(54),
                  child: Text('第${index}条'),
                  // child: Text(
                  //   '${this._hotProductList[index].price}',
                  //   style: TextStyle(color: Colors.red),
                  // ),
                )
              ],
            );
            // onTap
          },
          scrollDirection: Axis.horizontal,
          itemCount: 9,
        ),
      );
    // }else{
    //   return Text('暂无热门推荐数据');
    // }

  }
// 网络请求的热门商品
  Widget _recProductListWidget() {
    var itemWidth = (ScreeAdaper.getScreenWidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductList.map((value) {
          //图片：
          var sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');

          return Container(
            padding: EdgeInsets.all(ScreeAdaper.width(20)),
            width: itemWidth,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1)),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network("${sPic}", fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreeAdaper.height(10)),
                  child: Text(
                    "${value.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreeAdaper.height(20)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${value.price}",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "￥${value.oldPrice}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

//  单个的热门推荐数据
  Widget _recProductItemListWidget() {
    var itemWidth = (ScreeAdaper.getScreenWidth() - 30) / 2;
    return InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/productContent',arguments: {
            "id":"0"
          });
        },
        child:Container(
          padding: EdgeInsets.all(ScreeAdaper.width(20)),
          width: itemWidth,
          decoration:
          BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                      "https://www.itying.com/images/flutter/list1.jpg",
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreeAdaper.height(10)),
                child: Text(
                  '2019秋季大促2019秋季大促2019秋季大促2019秋季大促2019秋季大促2019秋季大促',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreeAdaper.height(20)),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '123',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '123',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

}