import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ourdate/util/ImageUtils.dart';

/**
 * Created by YHF at 15:28 on 2022-04-07.
 */
 
class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1000,
        height: 1000,
        color: Colors.green,
        child: Center(
          child: Container(
            width: 500,
            height: 500,
            color: Colors.white,
            child:Center(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                  backgroundBlendMode: BlendMode.dstIn,
                ),
                child: Image.asset(ImageUtils.getImagePath("login_qr_fail")),
              ),
            ),
          ),
        ),
      ),
    );
  }

  get(){
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.green,
        Colors.pink,
      ],
    );
  }
}


