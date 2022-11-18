import 'package:flutter/material.dart';
import 'package:ourdate/constant/Constant.dart';

/**
 * Created by YHF at 15:22 on 2022-03-24.
 */

class ImageUtils {

  static ImageProvider getAssetImage(String name, {String format = 'png'}){
    return AssetImage(ConstantPath.ImagePath + '/' +name + '.' + format);
  }

  static String getImagePath(String name, {String format = 'png'}){
    return ConstantPath.ImagePath + '/' +name + '.' + format.toString();
  }

}