/**
 * Created by YHF at 14:42 on 2022-03-24.
 */

import 'package:flutter/material.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';

class Toast {
  static OverlayEntry? _overlayEntry; // toast靠它加到屏幕上
  static bool _showing = false;      // toast是否正在showing
  static late DateTime _startedTime;      // 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static late String _msg;                // 提示内容
  static late int _showTime;              // toast显示时间
  static TextStyle? _style;
  static bool lock = false;
  static void show(BuildContext context, String msg, {int showTime = 2000, TextStyle? style}) async {
    OverlayState? overlayState = Overlay.of(context);
    _msg = msg;
    lock = false;
    _startedTime = DateTime.now();
    _showTime = showTime;
    _style = style;
    //获取OverlayState
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
            child: AnimatedOpacity(
              opacity: _showing ? 1.0 : 0.0, //目标透明度
              duration:Duration(milliseconds: 400),
              child: _buildToastWidget(context),
            ),
          ));
      overlayState?.insert(_overlayEntry!);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry?.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: _showTime)); // 等待时间

    //2秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= _showTime) {
      _showing = false;
      if (_overlayEntry != null) {
        _overlayEntry?.markNeedsBuild();
        await Future.delayed(Duration(milliseconds: 400));
        _overlayEntry?.remove();
        _overlayEntry = null;
      }

    }
  }

  //toast绘制
  static _buildToastWidget(BuildContext context) {
    return Container(
      height: Scr.screenHeight,
      width: Scr.screenWidth,
      color: Colors.black,
      alignment: Alignment.center,
      child: Container(
        height: Scr.px(450),
        width: Scr.screenWidth*0.8,
        alignment: Alignment.center,
        padding: EdgeInsets.all(Scr.px(10)),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.all(Radius.circular(Scr.px(10)))
        ),
        child: Text(
          _msg,
          textAlign: TextAlign.center,
          style: _style??TextStyle(
              fontSize: Scr.font(30),
              color: Colors.white,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none
          ),
        ),
      ),
    );
  }

}