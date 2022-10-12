
import 'package:flutter/material.dart';

class CommonWidget {

  static isLoaderShow(bool isLoaderShow, Color colors) {
    return Visibility(
      visible: isLoaderShow,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(150.0),
        child: Image(image: const AssetImage("assets/images/new_splash_main.gif"),
          color: colors,),
      ),

    );
  }
}