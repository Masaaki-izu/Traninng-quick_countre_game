import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../provider/timer.dart';
import '../etc/cs.dart';

class TimerTextWidget extends HookWidget {
  final double? scaleSize;

  const TimerTextWidget({Key? key,this.scaleSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeLeft = useProvider(timeLeftProvider);

    return Text(
      timeLeft,
      style: TextStyle(
          fontSize: scaleSize! * 10.0 ,
          fontFamily: fontName1,
          color: Colors.white),
    );
  }
}