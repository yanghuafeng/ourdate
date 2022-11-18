
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'IRouterProvider.dart';

/**
 * Created by YHF at 16:59 on 2021-09-08.
 */

class ServicesRouter extends IRouterProvider{

  static String servicePage = '/service';




  @override
  void initRouter(FluroRouter router) {
    router.define(servicePage, handler:
    Handler(handlerFunc: (_,params){return Container();})
    );

  }
}