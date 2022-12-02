import 'package:flutter/material.dart';
import 'package:ourdate/manager/MemorialDay.dart';
import 'package:ourdate/manager/Schedule.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';

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
    return Container(
      height: Scr.px(150),
      width: Scr.screenWidth,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: Scr.px(1),color: Colors.white))
      ),
      padding: EdgeInsets.all(Scr.px(10)),
      alignment: Alignment.centerLeft,
      child: Text("${widget.index+1}."+schedule.describe.toString(),style: TextStyle(
        color: Colors.white,
        fontSize: Scr.font(35),
      ),),
    );
  }
}
