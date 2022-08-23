



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jing_dong_app/services/ScreenAdaper.dart';

class JdButton extends StatelessWidget{
  final Color bgColor;
  final String buttonText;
  final GestureTapCallback onClick;

  JdButton({this.bgColor = Colors.black,this.buttonText = "按钮",required this.onClick}):super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        height: ScreeAdaper.height(68),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(buttonText,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
