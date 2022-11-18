
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


import 'IRouterProvider.dart';
import 'ServicesRouter.dart';

/**
 * Created by YHF at 17:05 on 2021-09-08.
 */
class MainRouter {

  static String load = "/load";
  static String order = "/order";
  static String payment = "/payment";
  static String bill = "/bill";
  static String menu = "/menu";
  static String vip = "/vip";
  static String vip_draw = "/vip_draw";
  static String shoppingcart = "/shoppingcart";

  //自助开房
  static String open_room_item = "/open_room_item";
  static String open_room_detail = "/open_room_detail";
  static String open_room_pay = "/open_room_pay";

  //子router管理集合
  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(FluroRouter router) {

    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          return Container(child: Text("未找到目标页"),);
        });


    // router.define(order, handler: Handler(
    //     handlerFunc: (BuildContext? context, Map<String, List<String>> params) => OrderPage()));
    //
    //


    //每次初始化前 先清除集合 以免重复添加
    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(ServicesRouter());


    /// 初始化路由 循环遍历取出每个子router进行初始化操作
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }
}