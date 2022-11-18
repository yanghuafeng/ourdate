part of 'ScreenAdaptor.dart';

/**
 * Created by YHF at 9:59 on 2022-03-24.
 */

extension NumExtension on num{
  get scr{
    return Scr.px(this.toDouble());
  }
}