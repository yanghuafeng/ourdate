import 'dart:convert';

import 'package:ourdate/constant/Constant.dart';
import 'package:ourdate/util/Utils.dart';

/**
 * Created by YHF at 16:41 on 2022-11-28.
 */
 
class MemorialDay{
  int? day;
  int? month;
  int? year;
  String? describe;
  bool loop = false;

  MemorialDay({this.day,this.month,this.year,this.describe,this.loop = false});

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'day': day,
        'month': month,
        'year': year,
        'describe': describe,
        'loop': loop,
      };

  MemorialDay.fromJson(Map<String, dynamic> json)
      : day = json['day'],
        month = json['month'],
        year = json['year'],
        describe = json['describe'],
        loop = json['loop'];

}


class DstDay extends MemorialDay{
  int dstDay = -1;//还剩多少天
  int num = 1;//第几次

  DstDay(MemorialDay day){
    this.day = day.day;
    this.month = day.month;
    this.year = day.year;
    this.describe = day.describe;
    this.loop = day.loop;
  }
}

class DiyDay{
  String? describe;
  List<MemorialDay> dayList = [];

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'describe': describe,
        'dayList': dayList,
      };

  DiyDay();
  DiyDay.fromJson(Map<String, dynamic> json)
      : describe = json['describe'],
        dayList = (json['dayList'] as List).map(
                (e) => MemorialDay.fromJson(e as Map<String, dynamic>)).toList();
}

class MemorialDays{

  // static MemorialDay hundred = new MemorialDay(day: 100, describe: "第100天");
  // static MemorialDay thousand = new MemorialDay(day: 1000, describe: "第1000天");
  // static MemorialDay tenThousand = new MemorialDay(day: 10000, describe: "第10000天");
  //
  // static MemorialDay firstMonth = new MemorialDay(month: 1, describe: "第一个月");
  // static MemorialDay thirdMonth = new MemorialDay(month: 3, describe: "第三个月");
  // static MemorialDay sixthMonth = new MemorialDay(month: 6, describe: "第六个月");
  //
  // static MemorialDay everyYear = new MemorialDay(year: 1, describe: "一年");

  static List<MemorialDay> memorialDayList=[
    MemorialDay(day: 100, describe: "100天",),
    MemorialDay(day: 1000, describe: "1000天",loop: true),
    MemorialDay(day: 10000, describe: "10000天",loop: true),
    MemorialDay(month: 1, describe: "一个月"),
    MemorialDay(month: 3, describe: "三个月"),
    MemorialDay(month: 6, describe: "六个月"),
    MemorialDay(year: 1, describe: "一年",loop: true),
  ];


  static DiyDay diyDay = new DiyDay();

  static Future addDiy(MemorialDay day)async{
    diyDay.describe = "自定义";
    diyDay.dayList.add(day);

    String tempJson = json.encode(diyDay);
    await Utils.saveString(SpKey.diyKey, tempJson);
  }

  static Future initDiy()async{
    String diyString = await Utils.getString(SpKey.diyKey);
    if(diyString.isEmpty)return;
    Map<String, dynamic> tempJson = json.decode(diyString);
    diyDay = DiyDay.fromJson(tempJson);
  }


}