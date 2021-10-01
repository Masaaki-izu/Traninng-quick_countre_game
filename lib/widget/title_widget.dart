import 'package:flutter/material.dart';
import '../etc/size_config.dart';
import '../etc/cs.dart';

class TitleWidget extends StatelessWidget {
  final safeBlockHorizontal;
  TitleWidget({Key? key,this.safeBlockHorizontal}) : super(key: key);

  final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize:  SizeConfig.safeBlockHorizontal! * 14.5,
      fontFamily: fontName2);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Quick',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            Text(
              'Countre',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
