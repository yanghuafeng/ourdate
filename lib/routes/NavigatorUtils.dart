/**
 * Created by YHF at 17:11 on 2021-09-08.
 */

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../Application.dart';
import 'MainRouter.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {

  //不需要页面返回值的跳转
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.fadeIn);
  }

  //需要页面返回值的跳转
  static pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }


  /// 返回
  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context, result);
  }

  static void goBackTo(BuildContext context, String path) {
    Navigator.popUntil(context, ModalRoute.withName(path));
  }

  static popRoot(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.popUntil(context, (route) {
        return route.isFirst;
      });
    }
  }

  static popToHome(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.popUntil(context, (route) {
        return route.settings.name!.contains(MainRouter.order);
      });
    }
  }

}