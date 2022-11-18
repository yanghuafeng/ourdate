/**
 * Created by YHF at 14:28 on 2021-09-03.
 */

import 'dart:ui';

import 'package:flutter/material.dart';

part 'NumExtension.dart';

class Scr {

  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _pixelRatio = mediaQuery.devicePixelRatio;
  static double _screenWidth = mediaQuery.size.width;
  static double _screenHeight = mediaQuery.size.height;
  static double _statusBarHeight = mediaQuery.padding.top;
  static double _bottomBarHeight = mediaQuery.padding.bottom;
  static double _textScaleFactor = mediaQuery.textScaleFactor;

  static bool isPort = _screenHeight>_screenWidth;
  //设计稿的设备尺寸
  static double _height = isPort?1920:1080;
  static double _width = isPort?1080:1920;


  static MediaQueryData get mediaQueryData => mediaQuery;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  //设备的像素密度
 // static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  static double get screenWidth => _screenWidth;

  ///当前设备高度 dp
  static double get screenHeight => _screenHeight;

  ///状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;

  ///底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;

  ///实际的 dp 与设计稿 px 的比例
  static get scaleWidth => _screenWidth / _width;
  static get scaleHeight => _screenHeight / _height;

  ///根据设计稿的设备宽度适配
  ///保证横竖屏尺寸一致
  static double px(double value) => value * (isPort?scaleWidth:scaleHeight);

  static font(double fontSize) => px(fontSize);

  static reset(){
    mediaQuery = MediaQueryData.fromWindow(window);
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;

    isPort = _screenHeight>_screenWidth;
    //设计稿的设备尺寸
    _height = isPort?1920:1080;
    _width = isPort?1080:1920;
  }

  static heightScale(double value){
    return value*_screenHeight;
  }

  static widthScale(double value){
    return value*_screenWidth;
  }

}