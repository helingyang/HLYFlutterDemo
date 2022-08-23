import 'package:flutter/material.dart';
import 'package:jing_dong_app/routes/search.dart';
import '../Viewcontrollers/CategoryViewControllers/ProductList.dart';
import '../Viewcontrollers/OtherViewControllers/ProductContent.dart';
import '../tabs/Tabs.dart';
//配置路由的地方：
final routes = {
  '/': (context) => Tabs(),
  '/productList': (context,{arguments}) => ProductListPage(arguments),
  '/productContent': (context,{arguments}) => ProductContentPage(arguments)
  // '/search': (context) => SearchPage(),
};
//固定写法：
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
      MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};