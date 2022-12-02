
import 'package:flutter/material.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';

import 'BaseDialog.dart';

/**
 * Created by YHF at 15:59 on 2020-04-28.
 */

class ChooseConfirmDialog extends StatelessWidget{
  Function confirmCallback;
  Function? cancleCallback;
  Widget content;
  bool autoClose;

  ChooseConfirmDialog({
    required this.confirmCallback,
    required this.content,
    this.autoClose = true,
    this.cancleCallback
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
                InkWell(
                  onTap: (){
                    cancleCallback==null?BaseDialog.close():cancleCallback!();
                  },
                  child: Text("取消",
                    style: TextStyle(
                        fontSize: Scr.font(35),
                        color: Color(0xfff64343),
                        decoration: TextDecoration.none
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: Scr.px(50)),
                  child: InkWell(
                    onTap: (){
                      confirmCallback();
                      if(autoClose) {
                        BaseDialog.close();
                      }
                    },
                    child: Text("确定",
                      style: TextStyle(
                          fontSize: Scr.font(35),
                          color: Colors.green,
                          decoration: TextDecoration.none
                      ),
                    ),
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