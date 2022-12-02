import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ourdate/util/Log.dart';

class BaseDialog {

  static List<OverlayEntry> entryList = [];

  static showDialog(Widget? content, BuildContext context, {bool outsideClosible = true,}) async {
    if (context == null) {
      return;
    }

    OverlayEntry entry = OverlayEntry(builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
          onTap: () {
            outsideClosible ? close() : () {};
          },
          behavior: HitTestBehavior.deferToChild,
          child: overlayView(content),
        ),
      );
    });
    Overlay.of(context)?.insert(entry);

    entryList.add(entry);
    Log.d("BaseDialog insert 1,total:" + entryList.length.toString());
  }

  static Widget overlayView(Widget? contentView) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Center(child: contentView),
      ),
    );
  }

  //有问题先屏蔽
  // static closeAll()  {
  //   for(OverlayEntry? entry in entryList){
  //     entry?.remove();
  //     entry = null;
  //     entryList.remove(entry);
  //   }
  //   Log.d("BaseDialog remove all,total:" + entryList.length.toString());
  //
  // }

  static  close()  {
    OverlayEntry? entry = entryList.last;
    entryList.remove(entry);
    entry.remove();
    entry = null;
    Log.d("BaseDialog remove 1,total:" + entryList.length.toString());

  }
}