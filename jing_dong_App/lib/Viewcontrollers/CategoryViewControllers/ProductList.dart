import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';

import '../../config/Config.dart';
import '../../model/ProductModel.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage(this.arguments);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListPagaState();
  }
}

class _ProductListPagaState extends State<ProductListPage> {

//通过事件打开侧边栏，需要全局声明一下：
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();

  //配置下拉加载更多：
  ScrollController _scrollController = ScrollController();

  int _page = 1;

  int _pageSize = 10;

  List _produceList = [];

  String _sort = "";

  //解决重复请求的问题：
  bool flag = true;

  //是否有数据：
  bool _hasMore = true;

  // http://jd.itying.com/api/plist?cid=10&page=1&sort=&pageSize=10

  // 一级导航数据
  /*
  价格升序：sort=price_1
  价格降序：sort=price_-1
  销量升序：sort=salecount_1
  销量降序：sort=salecount_-1
   */
  List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": 'all', "sort": -1},
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"},
  ];
  int _selectHeaderId = 1;

  @override
  initState(){
    super.initState();
    _getProductlistData();//现请求数据
    // 添加监听
    _scrollController.addListener(() {
      if(_scrollController.position.pixels>_scrollController.position.maxScrollExtent-20){
        if(this.flag&&this._hasMore){
          _getProductlistData();
        }
      }
    });
  }

  _getProductlistData()async{
    setState(() {
      this.flag = false;//请求中，设置是否可请求为false
    });

    var api =
        '${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${_page}&sort=${this._sort}&pageSize=${_pageSize}';
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);
    print(productList.result);

    if(productList.result.length<this._pageSize){
      setState(() {
        this._produceList.addAll(productList.result);
        this._hasMore = false;//是否有更多
        this.flag = true;//是否可以加载
      });
    }else{
      setState(() {
        this._produceList.addAll(productList.result);
        this._page++;
        this.flag = true;//是否可以加载
      });
    }
  }

//显示加载中的圈圈
  Widget _showMore(index){
    if(this._hasMore){
      // return (index == this._produceList.length-1)? LoadingWidget() :Text("");
      // return (index == this._produceList.length-1)? Text("---加载更多--") :Text("");
      return Text("---加载更多--");
    }else{
      // return (index == this._produceList.length - 1)? Text("---暂无其他数据了--") : Text('');
      return Text("---暂无其他数据了--");
    }
  }


//商品列表
  Widget _productListWidget() {
    // if (this._produceList.length>0){
      return Container(
        padding: const EdgeInsets.only(left: 10,right: 10),
        margin: EdgeInsets.only(top: ScreeAdaper.height(80)),
        child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    height: ScreeAdaper.height(220),
                    width: ScreeAdaper.width(220),
                    child: Image.network(
                        // "https://pics6.baidu.com/feed/908fa0ec08fa513d5c934fb0adc544f2b3fbd9d0.jpeg?token=7935b8fda9e7bbcbb255fa929a93b2b6",
                        "https://www.itying.com/images/flutter/list2.jpg",
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreeAdaper.height(240),
                        margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              '戴尔戴尔戴尔戴尔戴尔戴戴尔戴尔戴尔戴尔戴尔戴戴尔戴尔戴尔戴尔戴尔戴',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: ScreeAdaper.height(36),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  //注意：如果Container里面加上decoration属性，这个时候color属性必须放到BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color:Color.fromRGBO(230, 230, 230, 0.9)
                                  ),
                                  child: Text('4G'),
                                ),
                                Container(
                                  height: ScreeAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  //注意：如果Container里面加上decoration属性，这个时候color属性必须放到BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color:Color.fromRGBO(230, 230, 230, 0.3)
                                  ),
                                  child: Text('16G'),
                                )
                              ],
                            ),
                            Text('￥2999', style: TextStyle(color: Colors.red))
                          ],
                        ),
                      )
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              _showMore(index)
            ],
          );
        },
          itemCount: 10,
        // itemCount: _produceList.length,
        ),

      );
    // }else{
    //   return Text("---加载更多数据--");
    // }
  }

  //导航改变的时候触发：
  _subHeaderChange(id) {
    if(id==4){
      _scaffoldKey.currentState?.openEndDrawer();
    }
    setState(() {
      this._selectHeaderId = id;
      this._sort = "${this._subHeaderList[id - 1]['fileds']}_${this._subHeaderList[id - 1]['sort']}";

      //重置分页：
      this._page = 1;
      //重置数据：
      this._produceList = [];

      this._subHeaderList[id - 1]['sort'] =
          this._subHeaderList[id - 1]['sort'] * -1;

      //回到顶部：
      _scrollController.jumpTo(0);

      //重置_hasMore
      this._hasMore = true;

      //重新请求数据：
      this._getProductlistData();
    });
  }

  Widget _showIcon(id){
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]['sort'] ==1) {
        return Icon(Icons.arrow_drop_down);
      }
      return Icon(Icons.arrow_drop_up);
    }
    return Text('');
  }

  Widget _subHeaderWidget(){
    return Positioned(
        top: 0,
        height: ScreeAdaper.height(80),
        width: ScreeAdaper.width(750),
        child: Container(
          height: ScreeAdaper.height(80),
          width: ScreeAdaper.width(750),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,color: Color.fromRGBO(233, 233, 233, 0.9)
              )
            )
          ),
          child: Row(
            children: this._subHeaderList.map((e) {
              return Expanded(
               flex: 1,
               child: InkWell(
                 child: Padding(
                   padding: EdgeInsets.fromLTRB(0, ScreeAdaper.height(20), 0, ScreeAdaper.height(20)),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         "${e['title']}",
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           color: (this._selectHeaderId == e["id"])?Colors.red:Colors.black
                         ),
                       ),
                       _showIcon(e["id"])
                     ],
                   ),
                 ),
                 onTap: (){
                   _subHeaderChange(e["id"]);
                 },
               ),
              );
            }).toList(),
          ),
          // child: Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //         child: InkWell(
          //           child: Padding(
          //             padding: EdgeInsets.fromLTRB(0, ScreeAdaper.height(20), 0, ScreeAdaper.height(20)),
          //             child: const Text(
          //               "综合",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(color: Colors.red),
          //             ),
          //           ),
          //           onTap: (){
          //             // _scaffoldKey.currentState?.openDrawer();
          //           },
          //     )),
          //     Expanded(
          //         flex: 1,
          //         child: InkWell(
          //           child: Padding(
          //             padding: EdgeInsets.fromLTRB(0, ScreeAdaper.height(20), 0, ScreeAdaper.height(20)),
          //             child: const Text(
          //               "销量",
          //               textAlign: TextAlign.center,
          //               // style: TextStyle(color: Colors.red),
          //             ),
          //           ),
          //           onTap: (){
          //
          //           },
          //         )),
          //     Expanded(
          //         flex: 1,
          //         child: InkWell(
          //           child: Padding(
          //             padding: EdgeInsets.fromLTRB(0, ScreeAdaper.height(20), 0, ScreeAdaper.height(20)),
          //             child: const Text(
          //               "价格",
          //               textAlign: TextAlign.center,
          //               // style: TextStyle(color: Colors.red),
          //             ),
          //           ),
          //           onTap: (){
          //
          //           },
          //         )),
          //     Expanded(
          //         flex: 1,
          //         child: InkWell(
          //           child: Padding(
          //             padding: EdgeInsets.fromLTRB(0, ScreeAdaper.height(20), 0, ScreeAdaper.height(20)),
          //             child: const Text(
          //               "筛选",
          //               textAlign: TextAlign.center,
          //               // style: TextStyle(color: Colors.red),
          //             ),
          //           ),
          //           onTap: (){
          //             _scaffoldKey.currentState?.openEndDrawer();
          //           },
          //         )),
          //   ],
          // ),
    ));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreeAdaper.init(context);
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("商品列表"),
        // actions: const [
        //   Text("")
        // ],
      ),
      // drawer: Drawer(
      //   child: Container(
      //     child: const Text("zon"),
      //   ),
      // ),
      // endDrawer: Drawer(
      //   child: Container(
      //     child: const Text("实现筛选功能"),
      //   ),
      // ),
      body: Stack(
        children: [_productListWidget(),_subHeaderWidget()],
      ),
      // body: Padding(
      //     padding: EdgeInsets.all(10),
      //     child: ListView.builder(itemBuilder: (context, index) {
      //       return Row(
      //         children: [
      //           Container(
      //             height: ScreeAdaper.height(220),
      //             width: ScreeAdaper.width(220),
      //             child: Image.network(
      //                 "https://pics6.baidu.com/feed/908fa0ec08fa513d5c934fb0adc544f2b3fbd9d0.jpeg?token=7935b8fda9e7bbcbb255fa929a93b2b6",
      //                 fit: BoxFit.cover),
      //           ),
      //           Expanded(
      //               flex: 1,
      //               child: Container(
      //                 height: ScreeAdaper.height(240),
      //                 margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: <Widget>[
      //                     Text(
      //                       '戴尔戴尔戴尔戴尔戴尔戴戴尔戴尔戴尔戴尔戴尔戴戴尔戴尔戴尔戴尔戴尔戴',
      //                       maxLines: 2,
      //                       overflow: TextOverflow.ellipsis,
      //                     ),
      //                     Row(
      //                       children: <Widget>[
      //                         Container(
      //                           height: ScreeAdaper.height(36),
      //                           margin: const EdgeInsets.only(right: 10),
      //                           padding:
      //                               const EdgeInsets.fromLTRB(10, 0, 10, 0),
      //                           //注意：如果Container里面加上decoration属性，这个时候color属性必须放到BoxDecoration
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(10),
      //                             // color:Color.fromRGBO(230, 230, 230, 0.9)
      //                           ),
      //                           child: Text('4G'),
      //                         ),
      //                         Container(
      //                           height: ScreeAdaper.height(36),
      //                           margin: EdgeInsets.only(right: 10),
      //                           padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      //                           //注意：如果Container里面加上decoration属性，这个时候color属性必须放到BoxDecoration
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(10),
      //                             // color:Color.fromRGBO(230, 230, 230, 0.3)
      //                           ),
      //                           child: Text('16G'),
      //                         )
      //                       ],
      //                     ),
      //                     Text('￥2999', style: TextStyle(color: Colors.red))
      //                   ],
      //                 ),
      //               )),
      //         ],
      //       );
      //     })),
    );
  }
}


