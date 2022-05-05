import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //轮播图：
  //flutter run -d all 链接多个设备的命令：
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"}
    ];

    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              imgList[index]['url'],
              fit: BoxFit.fill,
            );
          },
          itemCount: imgList.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
          autoplay: true,
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: 10),
        _titleWidget("猜你喜欢"),
        SizedBox(height: 10),
        _titleWidget("热门推荐")
      ],
    );
  }
}