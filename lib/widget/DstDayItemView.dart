import 'package:flutter/material.dart';
import 'package:ourdate/manager/MemorialDay.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';

/**
 * Created by YHF at 9:49 on 2022-11-30.
 */
 
class DstDayItemView extends StatefulWidget {

  DstDay dstDay;
  int index;
  DstDayItemView(this.dstDay,this.index,{Key? key}) : super(key: key);

  @override
  State<DstDayItemView> createState() => _DstDayItemViewState();
}

class _DstDayItemViewState extends State<DstDayItemView> {
  late DstDay dstDay;

  @override
  void initState() {
    super.initState();
    dstDay = widget.dstDay;
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
      child: Text("${widget.index+1}."+getDescribeString(),style: TextStyle(
        color: Colors.white,
        fontSize: Scr.font(35),
      ),),
    );
  }

  getDescribeString(){
    String ret = "距离";
    if(dstDay.loop){
      ret=ret + "第${dstDay.num}个"+dstDay.describe!+"还有${dstDay.dstDay}天";
    }else{
      ret=ret + dstDay.describe!+"还有${dstDay.dstDay}天";
    }
    return ret;
  }
}
