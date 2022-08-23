import 'package:flutter/material.dart';
import 'package:jing_dong_app/Views/JDButton.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';
class ProductContentFirst extends StatefulWidget {
  ProductContentFirst() : super();

  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {

  _productSelectView(){
    //底部弹出框
    showModalBottomSheet(
      context:context,
      builder: (context){
        return GestureDetector(
          onTap: (){
            // return false;
          },
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(ScreeAdaper.width(20)),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Wrap(
                          children: [
                            Container(
                              width: ScreeAdaper.width(100),
                              child: Padding(
                                padding: EdgeInsets.only(top: ScreeAdaper.height(35)),
                                child: Text(
                                  "颜色",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: ScreeAdaper.width(610),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("蓝色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("黑色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: ScreeAdaper.width(750),
                height: ScreeAdaper.height(76),
                child: Row(
                  children: [
                    Container(
                      width: ScreeAdaper.width(750),
                      height: ScreeAdaper.height(76),
                      child: Row(
                        children: [
                          Expanded(flex: 1,child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: JdButton(
                              bgColor: Color.fromRGBO(253, 1, 0, 0.9),
                              buttonText: "加入购物车",
                              onClick: () {
                                print("加入购物车按钮");
                              },
                            ),
                          )),
                          Expanded(flex: 1,child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: JdButton(
                              bgColor: Color.fromRGBO(253, 1, 0, 0.9),
                              buttonText: "立即购买",
                              onClick: () {
                                print("立即购买按钮");
                              },
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(aspectRatio: 16/9,child: Image.network("https://www.itying.com/images/flutter/p1.jpg",
            fit: BoxFit.cover,),),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("联想ThinkPad，巨惠活动，卖完即止",style: TextStyle(
              color: Colors.black87,
              fontSize: ScreeAdaper.size(36)
            ),),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("联想ThinkPad，巨惠活动，卖完即止，标题标题挑剔标题标题挑剔标题标题挑剔标题标题挑剔标题标题挑剔",style: TextStyle(
                color: Colors.black54,
                fontSize: ScreeAdaper.size(28)
            ),),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                    flex:1,
                    child: Row(
                      children: [
                        Text("特价"),
                        Text("¥28",style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreeAdaper.size(46)
                        ),)
                      ],
                )),
                Expanded(
                    flex:1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("原价"),
                        Text("¥50",style: TextStyle(
                            color: Colors.black38,
                            fontSize: ScreeAdaper.size(28),
                            decoration: TextDecoration.lineThrough
                        ),)
                      ],
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: ScreeAdaper.height(80),
            child: InkWell(
              onTap: (){
                _productSelectView();
              },
              child: Row(
                children: [
                  Text("已选",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("115,黑色")
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black54,),
          Container(
            height: ScreeAdaper.height(80),
            child: Row(
              children: <Widget>[
                Text('运费',style: TextStyle(
                    fontWeight: FontWeight.bold
                )),
                Text('免运费')
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}