/**
 * Created by YHF at 16:10 on 2021-09-08.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class Application {
  static late FluroRouter router;//路由管理
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static String currentPage = "";

}