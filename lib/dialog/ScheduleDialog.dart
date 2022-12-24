import 'package:flutter/material.dart';
import 'package:ourdate/dialog/BaseDialog.dart';
import 'package:ourdate/manager/GlobalEventBus.dart';
import 'package:ourdate/manager/Schedule.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';
import 'package:ourdate/widget/CommonBtn.dart';

/**
 * Created by YHF at 18:04 on 2022-11-30.
 */
 
class ScheduleDialog extends StatefulWidget {
  Function? callback;
  ScheduleDialog({Key? key,this.callback,}) : super(key: key);

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Scr.screenWidth*0.8,
      height: Scr.screenWidth*0.6,
      alignment: Alignment.center,
      padding: EdgeInsets.all(Scr.px(30)),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("描述："),
                getEditText(),
              ],
            ),
          ),
          SizedBox(height: Scr.px(30),),
          CommonBtn("确 定",onTap: (){
            Schedule sch = new Schedule(
                describe:controller.text,
                setTime: DateTime.now().millisecondsSinceEpoch.toString()
            );

            ScheduleManager.list.add(sch);
            ScheduleManager.refresh();
            GlobalEventBus.event.fire(new MainPageRefresh());
            BaseDialog.close();
          },),
          SizedBox(height: Scr.px(30),),
        ],
      ),
    );
  }

  getEditText(){
    return Container(
      width: Scr.px(500),
      height: Scr.px(500),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(Scr.px(0)),
          filled: true,
         // counterText: "",
          border: OutlineInputBorder(borderSide: BorderSide.none),),
        controller: controller,
        style: TextStyle(fontSize: Scr.font(26), color: Colors.black,
            decoration: TextDecoration.none),
        cursorColor: Colors.black,

      ),
    );
  }
}
