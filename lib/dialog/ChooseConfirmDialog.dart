
import 'package:flutter/material.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';
import 'package:ourdate/widget/CommonBtn.dart';

import 'BaseDialog.dart';

/**
 * Created by YHF at 15:59 on 2020-04-28.
 */

class ChooseConfirmDialog extends StatelessWidget{
  Function confirmCallback;
  Function? cancleCallback;
  Widget content;
  bool autoClose;
  String? posTxt;
  String? negTxt;

  ChooseConfirmDialog({
    required this.confirmCallback,
    required this.content,
    this.autoClose = true,
    this.cancleCallback,
    this.negTxt,
    this.posTxt
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Scr.screenWidth*0.8,
      height: Scr.screenHeight*0.25,
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
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0,-0.1),
            child: Padding(
              padding:  EdgeInsets.all(Scr.px(6)),
              child: content,
            ),
          ),
          Align(
            alignment: Alignment(0.8,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonBtn(negTxt??"取消",
                  textColor: Colors.red,
                  onTap: (){
                    cancleCallback==null?BaseDialog.close():cancleCallback!();
                  },
                ),
                CommonBtn(posTxt??"确定",
                  onTap: (){
                    confirmCallback();
                    if(autoClose) {
                      BaseDialog.close();
                    }
                  }
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}