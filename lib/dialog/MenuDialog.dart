import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ourdate/constant/Constant.dart';
import 'package:ourdate/dialog/BaseDialog.dart';
import 'package:ourdate/dialog/ChooseConfirmDialog.dart';
import 'package:ourdate/dialog/ScheduleDialog.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';
import 'package:ourdate/util/ImageUtils.dart';
import 'package:ourdate/util/Toast.dart';
import 'package:ourdate/util/Utils.dart';

/**
 * Created by YHF at 10:12 on 2022-11-30.
 */
 
class MenuDialog extends StatefulWidget {
  Function? callback;
  MenuDialog({Key? key,this.callback}) : super(key: key);

  @override
  State<MenuDialog> createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Scr.screenWidth*0.8,
      height: Scr.screenWidth*0.6,
      alignment: Alignment.center,
      padding: EdgeInsets.all(Scr.px(30)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:Colors.white,width: Scr.px(2)),
        borderRadius: BorderRadius.all(Radius.circular(Scr.px(10))),
        boxShadow: [
          BoxShadow(
              color: Colors.white,
              blurRadius: Scr.px(10),
              spreadRadius: Scr.px(5),
          )
        ]
      ),

      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              ChooseConfirmDialog dialog = new ChooseConfirmDialog(
                  confirmCallback: ()async{
                    await Utils.saveInt(SpKey.DATE, -1);
                    exit(0);
                  },
                  content: Text("确认需要重新设置日期吗（需要重启应用）",style: TextStyle(
                      fontSize:Scr.font(30),
                      color: Colors.black
                  ),)
              );
              BaseDialog.showDialog(dialog, context);
            },
            child: Container(
              height: Scr.px(120),
              width: double.infinity,
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Image.asset(ImageUtils.getImagePath("edit"),width: Scr.px(60),height: Scr.px(60),),
                SizedBox(width: Scr.px(20),),
                Text("重新设置日期",style: TextStyle(
                  fontSize: Scr.font(35),
                  color: Colors.black,
                ),)
              ],),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Scr.px(10)),
            child: Container(height: Scr.px(1),width: double.infinity,color: Colors.black,),
          ),
          // SizedBox(height: Scr.px(30),),
          // GestureDetector(
          //   onTap: (){
          //     Toast.show(context, "还在做，别急");
          //   },
          //   child: Container(
          //     height: Scr.px(120),
          //     alignment: Alignment.centerLeft,
          //     child: Row(children: [
          //       Image.asset(ImageUtils.getImagePath("add"),width: Scr.px(60),height: Scr.px(60),),
          //       SizedBox(width: Scr.px(30),),
          //       Text("自定义纪念日",style: TextStyle(
          //         fontSize: Scr.font(35),
          //         color: Colors.black,
          //       ),)
          //     ],),
          //   ),
          // ),
          GestureDetector(
            onTap: (){
              BaseDialog.showDialog(ScheduleDialog(), context);
            },
            child: Container(
              height: Scr.px(120),
              width: double.infinity,
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Image.asset(ImageUtils.getImagePath("add"),width: Scr.px(60),height: Scr.px(60),),
                SizedBox(width: Scr.px(30),),
                Text("新增代办",style: TextStyle(
                  fontSize: Scr.font(35),
                  color: Colors.black,
                ),)
              ],),
            ),
          )
        ],
      ),

    );
  }
}
