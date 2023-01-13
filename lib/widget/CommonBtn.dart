import 'package:flutter/material.dart';
import 'package:ourdate/constant/Constant.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';

class CommonBtn extends StatefulWidget {
  String text;
  double? width;
  double? height;
  Function? onTap;
  Function? onLongPress;
  bool scale;
  Color? textColor;
  Color? borderColor;
  double? textSize;
  bool disable;

  CommonBtn(this.text,{Key? key,
    this.height,
    this.width,
    this.scale = false,
    this.onTap,
    this.onLongPress,
    this.textColor,
    this.borderColor,
    this.textSize,
    this.disable = false,
  }) : super(key: key);

  @override
  _CommonBtnState createState() => _CommonBtnState();
}

class _CommonBtnState extends State<CommonBtn> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;
  bool hl = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 100),)
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween(begin: 1.0,end: 0.85).animate(_controller);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          hl=true;
        });
        if(widget.scale) _controller.forward();
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          hl=false;
        });
        if(widget.scale) _controller.reverse();
      },
      onTapCancel: (){
        setState(() {
          hl=false;
        });
        if(widget.scale) _controller.reverse();
      },

      onLongPress: widget.onLongPress==null?null:(){
        if(!widget.disable) widget.onLongPress!();
      },
      onTap: (){
        if(widget.onTap!=null){
          if(!widget.disable) widget.onTap!();
        }
      },
      child: Transform.scale(
        scale: _animation.value,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Scr.px(5))),
              border: Border.all(width: Scr.px(2),color: widget.borderColor??Colors.black),
              color: hl?Colors.grey[300]:Colors.white
          ),
          child: Container(
            width: widget.width??Scr.px(200),
            height: widget.height??Scr.px(65),
            alignment: Alignment.center,
            child: Text(widget.text,
              style: TextStyle(
                  fontSize: widget.textSize??Scr.font(30),
                  color: widget.textColor??Colors.black,
                  decoration: TextDecoration.none
              ),
            ),
          ),
        ),
      ),
    );
  }

}

