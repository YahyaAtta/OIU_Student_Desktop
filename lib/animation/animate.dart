import 'package:flutter/material.dart';
class ScaleAnimate extends PageRouteBuilder{
  // ignore: prefer_typing_uninitialized_variables
  final page ;
  ScaleAnimate({this.page}) : super(pageBuilder: (context,animation,animation2) => page , transitionsBuilder:(context,animation,animation2,child){
    var begin =0.0;
    var end = 1.0;
    var tween  = Tween(begin: begin,end:end) ;
    var curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutBack) ;
    var tweendriven = tween.animate(curvesAnimation) ;
    return ScaleTransition(scale: tweendriven, child: child,) ;
  });
}