import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreeAdaper{
  static init(context){
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
  }

  static height(double value){
    return ScreenUtil.getInstance().setHeight(value);
  }

  static width(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }

  static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  }

  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }

  static size(double size) { //适配字体
    return ScreenUtil.getInstance().setSp(size);
  }

}