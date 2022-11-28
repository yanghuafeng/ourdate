import 'package:flutter/material.dart';
import 'package:ourdate/constant/Constant.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';
import 'package:ourdate/page/BasePage.dart';
import 'package:ourdate/util/Utils.dart';
import 'package:ourdate/widget/CommonBtn.dart';

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
  DateTime? dateTime = null;

  @override
  void initState(){
    super.initState();
    checkDateSet();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: loading?Container():dateTime==null?dateSetView():mainView(),
    );
  }

  mainView(){
    return Column(
      children: [
        Text("")
      ],
    );
  }

  dateSetView(){
    return Container(
      child: CommonBtn("选择日期",
        onTap: ()async{
          dateTime = await showDatePicker(
            context: context,
            initialDate: DateTime(2022,8,13,21,30),
            firstDate: DateTime(1970,1,1),
            lastDate: DateTime(2050,1,1),
            locale: Locale('zh'),
          );

          if(dateTime!=null) {
            await Utils.saveInt(SpKey.DATE, dateTime!.millisecondsSinceEpoch);
            setState(() {

            });
          }

        })
    );
  }

  checkDateSet()async{
    int time = await Utils.getInt(SpKey.DATE);
    if(time != -1){
      dateTime = new DateTime.fromMillisecondsSinceEpoch(time);
    }
    loading = false;
    setState(() {

    });
  }
}
