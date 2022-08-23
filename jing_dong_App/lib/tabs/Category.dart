import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';

import '../config/Config.dart';
import '../model/CateModel.dart';
class CategoryPage extends StatefulWidget {
  // CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {

  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    print("initState");
    _getLeftCateData();
  }

  //左侧数据：
  _getLeftCateData(){
    CateModel leftCateListmodel;
    rootBundle.loadString('assets/jsons/category.json').then((value){
      // var leftCateList = CateModel.fromJson(Category.json);
      var map = json.decode(value); // 解码
      // print("leftCatelist$map");
      leftCateListmodel = CateModel.fromJson(json.decode(value));
      // print("leftCatelist$leftCateList");
      _leftCateList = leftCateListmodel.result;
      // List a = leftCateList.result;
      // print("leftCatelist$a");
      setState(() {
        this._leftCateList = leftCateListmodel.result;
      });

      _getRightCateData(leftCateListmodel.result[0].sId);
    });


  }

  //右侧数据：
  _getRightCateData(pid){
  // async {
    // var api = '${Config.domain}api/pcate?pid=${pid}';
    // var result = await Dio().get(api);
    // var rightCateList = CateModel.fromJson(result.data);
    // setState(() {
    //   this._rightCateList = rightCateList.result;
    // });
    var api = 'assets/jsons/CategoryRight${pid}.json';
    CateModel RightCateListmodel;
    rootBundle.loadString(api).then((value){
      // var leftCateList = CateModel.fromJson(Category.json);
      var map = json.decode(value); // 解码
      // print("leftCatelist$map");
      RightCateListmodel = CateModel.fromJson(json.decode(value));
      // print("leftCatelist$leftCateList");
       _rightCateList = RightCateListmodel.result;
      // List a = leftCateList.result;
      // print("leftCatelist$a");
      setState(() {
        this._rightCateList = RightCateListmodel.result;
      });
    });
  }

  // //左侧数据：
  // _getLeftCateData() async {
  //   var api = '${Config.domain}api/pcate';
  //   var result = await Dio().get(api);
  //   var leftCateList = CateModel.fromJson(result.data);
  //   setState(() {
  //     this._leftCateList = leftCateList.result;
  //   });
  //   _getRightCateData(leftCateList.result[0].sId);
  // }
  //
  // //右侧数据：
  // _getRightCateData(pid) async {
  //   var api = '${Config.domain}api/pcate?pid=${pid}';
  //   var result = await Dio().get(api);
  //   var rightCateList = CateModel.fromJson(result.data);
  //   print(6666);
  //   setState(() {
  //     this._rightCateList = rightCateList.result;
  //   });
  // }

  //左侧组件
  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        // color: Colors.red,
        child: ListView.builder(
          itemCount: this._leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      // setState(() {
                      _selectIndex = index;
                      this._getRightCateData(this._leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreeAdaper.height(86),
                    padding: EdgeInsets.only(top: ScreeAdaper.height(24)),
                    child: Text("${this._leftCateList[index].title}",
                        textAlign: TextAlign.center),
                    color: _selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                Divider(height: 1),
              ],
            );
          },
        ),
      );
    } else {
      print("leftCatelist 没数据");
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  //右侧组件：
  Widget _rightCateWidget(rightItemWidth, rightItemHeigth) {
    if (this._rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          // color: Colors.blue,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeigth,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: this._rightCateList.length,
            itemBuilder: (context, index) {

              //处理图片：
              String pic=this._rightCateList[index].pic;
              // pic=Config.domain+pic.replaceAll('\\','/');
              return InkWell(
                // padding: EdgeInsets.all(ScreenAdaper.width(20)),
                onTap:(){
                  Navigator.pushNamed(context,'/productList',arguments: {
                    "cid":this._rightCateList[index].sId
                  });
                  print("GridView item  被点击：${index}");
                },
                child: Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                          "${pic}",
                          fit: BoxFit.cover),
                    ),
                    Container(
                      height: ScreeAdaper.height(42),
                      child: Text("${this._rightCateList[index].title}"),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
            child: Text('加载中...'),
          ));
    }
  }

  Widget build(BuildContext context) {
    ScreeAdaper.init(context);
    print("build");
    //计算右侧GridView宽高比：
    var leftWidth = ScreeAdaper.getScreenWidth() / 4;
    //右侧宽高=总宽度-左侧宽度-Gridview外层元素左右的Padding值-GridView中间的间距
    var rightItemWidth =
        (ScreeAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWidth = ScreeAdaper.width(rightItemWidth);
    var rightItemHeigth = rightItemWidth + ScreeAdaper.height(32);

    return Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeigth)
      ],
    );
  }
}