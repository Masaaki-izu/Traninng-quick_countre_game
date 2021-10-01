import 'package:flutter/material.dart';
import '../etc/size_config.dart';
import '../etc/cs.dart';

class GameDisplayExplanation extends StatelessWidget {
  final safeBlockHorizontal;
  GameDisplayExplanation({Key? key,this.safeBlockHorizontal}) : super(key: key);

  final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
      fontFamily: fontName2);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: safeBlockHorizontal * 0.2,
              ),
              for(var _count = 0; _count < strExplanation.length; _count++ )
                Text(
                  strExplanation[_count], //'FONT:',
                  style: textStyle,
                ),

            ],
          ),
        ),
      ),
    );
  }
}
