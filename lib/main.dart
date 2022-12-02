import 'dart:async';
import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ourdate/page/MainPage.dart';
import 'package:ourdate/routes/MainRouter.dart';
import 'package:ourdate/routes/ServicesRouter.dart';
import 'package:ourdate/util/Log.dart';

import 'Application.dart';


void main() {
  runApp(App());
}

class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

final EaseObserver observer = EaseObserver();
class AppState extends State<App> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    //创建一个Router对象
    final router = FluroRouter();
    //配置Routes注册管理
    MainRouter.configureRoutes(router);
    //将生成的router给全局化
    Application.router = router;


    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   Permission.storage.request();
    // });

  }


  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  //应用生命周期
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch:  Colors.grey,
        accentColor: Colors.grey, //listView滑动到边缘颜色
      //  fontFamily: "common",
      ),
      navigatorObservers: [observer],
      navigatorKey: Application.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      locale: Locale('zh'),
      home: MainPage(),

    );
  }


}

class EaseObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    if (route.settings.name != null) {
      Log.d('did push route:' + route.settings.name!);
      if(route.settings.name==ServicesRouter.servicePage){
      }else{
      }
    }
    Application.currentPage = route.settings.name.toString();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    Log.d("did pop route:${route.settings.name} previousRoute:${previousRoute?.settings.name}");
    Application.currentPage = previousRoute?.settings.name.toString()??"";
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    Log.d("did replace newRoute:${newRoute?.settings.name} oldRoute:${oldRoute?.settings.name}");

  }
}