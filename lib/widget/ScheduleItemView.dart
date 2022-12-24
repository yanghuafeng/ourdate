import 'package:flutter/material.dart';
import 'package:ourdate/dialog/BaseDialog.dart';
import 'package:ourdate/dialog/ChooseConfirmDialog.dart';
import 'package:ourdate/manager/GlobalEventBus.dart';
import 'package:ourdate/manager/MemorialDay.dart';
import 'package:ourdate/manager/Schedule.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';
import 'package:ourdate/util/ImageUtils.dart';
import 'package:ourdate/widget/ImageBtn.dart';

/**
 * Created by YHF at 9:49 on 2022-11-30.
 */

class ScheduleItemView extends StatefulWidget {

  Schedule schedule;
  int index;
  ScheduleItemView(this.schedule,this.index,{Key? key}) : super(key: key);

  @override
  State<ScheduleItemView> createState() => _ScheduleItemViewState();
}

class _ScheduleItemViewState extends State<ScheduleItemView> {
  late Schedule schedule;

  @override
  void initState() {
    super.initState();
    schedule = widget.schedule;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        ChooseConfirmDialog dialog = new ChooseConfirmDialog(
            confirmCallback: () {
              ScheduleManager.list.forEach((element) {
                if(element.setTime == schedule.setTime){
                  element.done = !schedule.done;
                }
              });
              ScheduleManager.refresh();
              GlobalEventBus.event.fire(new MainPageRefresh());

            },
            posTxt: schedule.done?"未完成":"完成",
            negTxt: "取消",
            content: Text(
              schedule.describe ?? "",
              style: TextStyle(fontSize: Scr.font(30), color: Colors.red),
            ));

        BaseDialog.showDialog(dialog, context);
      },
      child: Container(
        height: Scr.px(120),
        width: Scr.screenWidth,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: Scr.px(1),color: Colors.white)),
          color: schedule.done?Colors.pink[100] :Colors.transparent
        ),
        padding: EdgeInsets.all(Scr.px(10)),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text("${widget.index+1}."+schedule.describe.toString(),style: TextStyle(
              color: Colors.white,
              fontSize: Scr.font(35),
            ),),
            Visibility(
                visible: schedule.done, 
                child: Image.asset(ImageUtils.getImagePath("complete"),
                  width: Scr.px(50),height: Scr.px(50),color: Colors.pink[300],)
            ),
            Spacer(),
            ImageBtn("delete",width: Scr.px(50),height: Scr.px(50),onTap: (){
              ChooseConfirmDialog dialog = new ChooseConfirmDialog(
                  confirmCallback: () {
                    ScheduleManager.list.remove(schedule);
                    ScheduleManager.refresh();
                    GlobalEventBus.event.fire(new MainPageRefresh());

                  },
                  posTxt: "移除",
                  negTxt: "取消",
                  content: Text(
                    schedule.describe ?? "",
                    style: TextStyle(fontSize: Scr.font(30), color: Colors.red),
                  ));

              BaseDialog.showDialog(dialog, context);
            },shader: true,)
          ],
        ),
      ),
    );
  }
}
