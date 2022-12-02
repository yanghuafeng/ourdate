import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ourdate/constant/Constant.dart';
import 'package:ourdate/dialog/BaseDialog.dart';
import 'package:ourdate/dialog/MenuDialog.dart';
import 'package:ourdate/manager/MemorialDay.dart';
import 'package:ourdate/manager/Schedule.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';
import 'package:ourdate/page/BasePage.dart';
import 'package:ourdate/util/ImageUtils.dart';
import 'package:ourdate/util/Utils.dart';
import 'package:ourdate/widget/CommonBtn.dart';
import 'package:ourdate/widget/DstDayItemView.dart';
import 'package:ourdate/widget/ImageBtn.dart';
import 'package:ourdate/widget/ScheduleItemView.dart';
import 'package:ourdate/widget/Shimmer.dart';

/**
 * Created by YHF at 19:00 on 2022-11-21.
 */

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool loading = true;
  DateTime? baseDay = null;
  late DateTime now;
  List<DstDay> dstList = [];

  bool showDetail = true;

  @override
  void initState(){
    super.initState();
    init();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: loading?Container():baseDay==null?dateSetView():mainView(),
    );
  }

  mainView(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ImageUtils.getAssetImage("pblue",format: "jpeg"),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        children: [
          Container(height: Scr.px(150), width: Scr.screenWidth,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      BaseDialog.showDialog(MenuDialog(
                        callback: (){
                          setState(() {});
                        },
                      ), context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: Scr.px(20)),
                      child: Image.asset(ImageUtils.getImagePath("menu"),
                        color: Colors.white,
                        width: Scr.px(50),
                        height: Scr.px(50),
                      ),
                    ),

                  ),
                )
              ],
            ),
          ),
          Container(
            height: Scr.px(180),
            width: Scr.screenWidth,
            alignment: Alignment.center,
            child: Shimmer.fromColors(
              baseColor: Colors.transparent,
              highlightColor: Colors.pink,
              period: Duration(seconds: 2),
              child: Text(Utils.getDateString(baseDay!),style: TextStyle(
                fontSize: Scr.font(55),
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "title"
              ),),
            ),
          ),
          Container(
            height: Scr.px(120),width: Scr.screenWidth,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                showDetail=!showDetail;
                setState(() {

                });
              },
              child: Text(getTotal(),style: TextStyle(
                fontSize: Scr.font(40),
                color: Colors.white,
                fontFamily: "title",
                fontWeight: FontWeight.w500,
              ),),
            ),
          ),
          Container(
              padding: EdgeInsets.all(Scr.px(30)),
              height: Scr.px(500),
              width: Scr.screenWidth,
              child: dstView()
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(Scr.px(30)),
                child: scheduleView(),
              )
          )
        ],
      ),
    );
  }

  dstView(){
    return ListView.builder(
        itemCount: min(dstList.length,3),
        itemBuilder:(BuildContext context,int index){
          return DstDayItemView(dstList[index],index);
        });
  }
  scheduleView(){
    return ListView.builder(
        itemCount: ScheduleManager.list.length,
        itemBuilder:(BuildContext context,int index){
          return ScheduleItemView(ScheduleManager.list[index],index);
        });
  }

  dateSetView(){
    return Container(
      child: CommonBtn("选择日期",
        onTap: ()async{
          baseDay = await showDatePicker(
            context: context,
            initialDate: DateTime(2022,8,13,21,30),
            firstDate: DateTime(1970,1,1),
            lastDate: DateTime(2050,1,1),
            locale: Locale('zh'),
          );

          if(baseDay!=null) {
            await Utils.saveInt(SpKey.DATE, baseDay!.millisecondsSinceEpoch);
            await initDstDay();
            setState(() {

            });
          }

        })
    );
  }

  init()async{
    await MemorialDays.initDiy();
    await ScheduleManager.initSchedule();
    await getBaseDay();
    if(baseDay!=null) {
      await initDstDay();
    }

    loading = false;
    setState(() {

    });
  }

  getBaseDay()async{
    int time = await Utils.getInt(SpKey.DATE);
    if(time != -1){
      baseDay = new DateTime.fromMillisecondsSinceEpoch(time);
    }
  }

  getTotal(){
    String ret;
    if(showDetail){
      ret = now.difference(baseDay!).inDays.toString()+"天";
    }else{
      int year = now.year-baseDay!.year;
      int month = now.month-baseDay!.month;
      if(month<0){
        month+=12;
        year--;
      }
      ret = month.toString()+"個月";
      if(year>0){
        ret = year.toString()+"年零"+ret;
      }
    }

    return "在一起"+ret;
  }

  initDstDay()async{
    for(MemorialDay memorialDay in MemorialDays.memorialDayList){
      if(memorialDay.day!=null){
        checkByDay(memorialDay);
      }else if(memorialDay.month!=null){
        checkByMonth(memorialDay);
      }else if(memorialDay.year!=null){
        checkByYear(memorialDay);
      }
    }

    dstList.sort((a,b)=>a.dstDay.compareTo(b.dstDay));
  }

  checkByDay(MemorialDay memorialDay){
    Duration duration = now.difference(baseDay!);
    if(memorialDay.day!>=duration.inDays){
      DstDay dstDay = new DstDay(memorialDay);
      dstDay.dstDay = memorialDay.day!-duration.inDays;
      dstList.add(dstDay);
    }else if(memorialDay.loop){
      int num = (duration.inDays / memorialDay.day!).floor();
      if(num>0) {
        DstDay dstDay = new DstDay(memorialDay);
        dstDay.num=num+1;
        dstDay.dstDay = memorialDay.day!*(num+1)-duration.inDays;
        dstList.add(dstDay);
      }
    }
  }

  checkByMonth(MemorialDay memorialDay){
    int memorialMonth = memorialDay.month!;
    if((now.year-baseDay!.year)*12+now.month-baseDay!.month<=memorialMonth){
      int year = baseDay!.year;
      int month = baseDay!.month+memorialMonth;
      if(month>12){
        month-=12;
        year++;
      }
      int day = baseDay!.day;
      DateTime dstDateTime = new DateTime(year,month,day);
      Duration duration = dstDateTime.difference(now);
      if(duration.inDays<0)return;
      DstDay dstDay = new DstDay(memorialDay);
      dstDay.dstDay = duration.inDays;
      dstList.add(dstDay);
    }
  }

  checkByYear(MemorialDay memorialDay){
    int memorialYear = memorialDay.year!;

    for(int num=1;num<999;num++){
      int year = baseDay!.year+num*memorialYear;
      int month = baseDay!.month;
      int day = baseDay!.day;
      DateTime dstDateTime = new DateTime(year,month,day);
      Duration duration = dstDateTime.difference(now);
      if(duration.inDays>0){
        if(num>1 && !memorialDay.loop)return;
        DstDay dstDay = new DstDay(memorialDay);
        dstDay.dstDay = duration.inDays;
        dstDay.num = num;
        dstList.add(dstDay);
        return;
      }
    }

  }
}
