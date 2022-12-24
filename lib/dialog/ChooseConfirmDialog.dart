
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
      height: Scr.screenHeight*0.3,
      color: Colors.white.withOpacity(0.6),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonBtn(negTxt??"取消",
                  onTap: (){
                    cancleCallback==null?BaseDialog.close():cancleCallback!();
                  },
                ),
                Padding(
                  padding:  EdgeInsets.only(left: Scr.px(50)),
                  child: CommonBtn(posTxt??"确定",
                    onTap: (){
                      confirmCallback();
                      if(autoClose) {
                        BaseDialog.close();
                      }
                    }
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}