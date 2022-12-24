import 'package:flutter/material.dart';
import 'package:ourdate/constant/Constant.dart';
import 'package:ourdate/manager/ScreenAdaptor.dart';
import 'package:ourdate/util/ImageUtils.dart';

class ImageBtn extends StatefulWidget {
  String imageName;
  double? width;
  double? height;
  Function? onTap;
  Function? onLongPress;
  bool scale;
  bool disable;
  bool shader;

  ImageBtn(this.imageName,{Key? key,
    this.height,
    this.width,
    this.scale = false,
    this.onTap,
    this.onLongPress,
    this.disable = false,
    this.shader = false,
  }) : super(key: key);

  @override
  _ImageBtnState createState() => _ImageBtnState();
}

class _ImageBtnState extends State<ImageBtn> with SingleTickerProviderStateMixin{
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
        child: widget.shader?ShaderMask(
            shaderCallback: (Rect bounds){
              return LinearGradient(
                begin: hl?Alignment.centerLeft:Alignment.centerRight,
                end: hl?Alignment.centerRight:Alignment.centerLeft,
                colors: getColors(),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: getChild()
        ):getChild()
      ),
    );
  }

  getChild(){
    return Image.asset(ImageUtils.getImagePath(widget.imageName),
      width: widget.width,height: widget.height,fit: BoxFit.fill,);
  }

  List<Color> getColors() {
    if(widget.disable){
      return [
        BtnColor.contentColorStart.withOpacity(BtnColor.disable_color_opacity),
        BtnColor.contentColorEnd.withOpacity(BtnColor.disable_color_opacity)
      ];
    }
    return [BtnColor.contentColorStart, BtnColor.contentColorEnd];
  }
}

