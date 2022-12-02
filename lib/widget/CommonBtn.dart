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
  double? textSize;
  double? borderRadius;
  BoxBorder? border;
  bool disable;

  CommonBtn(this.text,{Key? key,
    this.height,
    this.width,
    this.scale = false,
    this.onTap,
    this.onLongPress,
    this.textColor,
    this.textSize,
    this.borderRadius,
    this.border,
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
              borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius??Scr.px(10))),
              border: widget.border,
              gradient: LinearGradient(
                begin: hl?Alignment.centerLeft:Alignment.centerRight,
                end: hl?Alignment.centerRight:Alignment.centerLeft,
                colors: getColors(),
              )
          ),
          child: Container(
            width: widget.width??Scr.px(200),
            height: widget.height??Scr.px(60),
            alignment: Alignment.center,
            child: Text(widget.text,
              style: TextStyle(
                  fontSize: widget.textSize??Scr.font(30),
                  color: getTextColor(),
                  decoration: TextDecoration.none
              ),
            ),
          ),
        ),
      ),
    );
  }

  getTextColor(){
    if(widget.textColor==null){
      return widget.disable? Colors.white.withOpacity(BtnColor.disable_color_opacity)
          :Colors.white;
    }else{
      return widget.disable? widget.textColor!.withOpacity(BtnColor.disable_color_opacity)
          :widget.textColor!;
    }
  }

  List<Color> getColors() {
    if(widget.disable){
      return [
        BtnColor.bgColorStart.withOpacity(BtnColor.disable_color_opacity),
        BtnColor.bgColorEnd.withOpacity(BtnColor.disable_color_opacity)
      ];
    }
    return [BtnColor.bgColorStart, BtnColor.bgColorEnd];
  }
}

