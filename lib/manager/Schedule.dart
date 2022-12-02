import 'dart:convert';

import 'package:ourdate/constant/Constant.dart';
import 'package:ourdate/util/Utils.dart';

/**
 * Created by YHF at 17:20 on 2022-11-30.
 */

class Schedule{
  String? dstTime;
  String? setTime;
  String? describe;
  bool done = false;

  Schedule({this.dstTime,this.setTime,this.describe,this.done = false});

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'dstTime': dstTime,
        'setTime': setTime,
        'describe': describe,
        'done': done,
      };

  Schedule.fromJson(Map<String, dynamic> json)
      : dstTime = json['dstTime'],
        setTime = json['setTime'],
        describe = json['describe'],
        done = json['done'];

}

class ScheduleManager{
  
  static List<Schedule> list = [];
  static Future refresh()async{

    List<String> jsonList = list.map((e){
      return json.encode(e);
    }).toList();
    
    await Utils.saveList(SpKey.scheduleKey, jsonList);
  }

  static Future initSchedule()async{
    List<String>jsonList = await Utils.getList(SpKey.scheduleKey);
    if(jsonList.isEmpty)return;
    List<Schedule> scheduleList = jsonList.map((e){
      Map<String, dynamic> tempJson = json.decode(e);
      Schedule schedule = Schedule.fromJson(tempJson);
      return schedule;
    }).toList();

    list = scheduleList;
  }
}