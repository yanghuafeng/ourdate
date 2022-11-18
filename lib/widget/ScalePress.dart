import 'package:flutter/material.dart';

/**
 * Created by YHF at 9:54 on 2022-03-28.
 */

class ScalePress extends StatefulWidget{
  Widget? child;
  Function? onTap;
  Function? onLongPress;

  ScalePress({@required this.child,this.onTap,this.onLongPress});

  @override
  State<StatefulWidget> createState() {
    return ScalePressState();
  }
}

class ScalePressState extends State<ScalePress> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;

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
    return  GestureDetector(
      onTapDown: (TapDownDetails details) {
        _controller.forward();
      },
      onTapUp: (TapUpDetails details) {
        _controller.reverse();
      },
      onTapCancel: (){
        _controller.reverse();
      },

      onLongPress: widget.onLongPress==null?null:(){
        widget.onLongPress!();
      },
      onTap: (){
        if(widget.onTap!=null){
          widget.onTap!();
        }
      },
      child: Transform.scale(
        scale: _animation.value,
        child: widget.child,
      ),
    );
  }
}