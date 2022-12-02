import 'package:common_utils/common_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Created by YHF at 17:54 on 2022-11-21.
 */

class Utils{

  static getDateString(DateTime dateTime){
    String ret = DateUtil.formatDate(dateTime,format: "yyyy年MM月dd日");
    return ret;
  }


  static Future saveString(String key, String value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }
  static Future<String> getString(String key, [String defaultValue = ""])async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }

  static Future saveInt(String key, int value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

  static Future<int> getInt(String key, [int defaultValue = -1])async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? defaultValue;
  }

  static Future saveList(String key, List<String> value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(key, value);

  }

  static Future<List<String>> getList(String key)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? [];
  }


}