/**
 * Created by YHF at 17:31 on 2022-03-28.
 */

import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;

  BasePage({Key? key, required this.child,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            child: child,
          )),
    );
  }


}
