import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_project/utils/utils.dart';

const HOME_PAGE = "oyy://home";

/**
 * 路由
 */
class MyRouter {
  static final MyRouter i = MyRouter._internal();

  factory MyRouter() => i;

  MyRouter._internal();

  static Function _routerMap;

  /// 打开页面
  /// MyRouter.push(context, 'mq://manqian.com/home');p''
  static push(context, String routeName, {String arguments = ''}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// 关闭页面
  /// MyRouter.pop(context);
  static pop(context) {
    Navigator.pop(context);
  }

  static setFlutterRouter(map) {
    _routerMap = map;
  }

  static init() => (RouteSettings settings) => isTransAnimate(
          settings.arguments)
      ? PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return SlideTransition(
              position: Tween<Offset>(
                      begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                  .animate(
                      CurvedAnimation(parent: animation, curve: Curves.ease)),
              child: build(settings)[settings.name],
            );
          },
          settings: settings,
        )
      : CupertinoPageRoute(
          builder: (context) => build(settings)[settings.name],
          settings: settings);

  static build(RouteSettings settings) {
    return _routerMap(settings);
  }

  //上下动画
  static isTransAnimate(String argument) {
    if (notEmpty(argument)) {
      Map params = queryToMap(argument);
      return params['animated'] == 'true';
    }
    return false;
  }

  // 重新定位到 targetRouter 路由再打开 routerName
  static redirectTo(context, String routerName, List targetRouterName,
      {String arguments = ''}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routerName,
      (route) {
        if (targetRouterName.contains(route.settings.name)) {
          return true;
        }
        return false;
      },
      arguments: arguments,
    );
  }
}
