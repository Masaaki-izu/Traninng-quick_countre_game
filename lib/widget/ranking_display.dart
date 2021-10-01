import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_countre_game/model/data_firestore.dart';
import '../etc/size_config.dart';
import '../etc/cs.dart';

class RankingDisplay extends HookWidget {
  final DataFirestore? dataFirestore;
  final int? letterSelectValue;

  RankingDisplay({Key? key,this.dataFirestore,this.letterSelectValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double fontSize0 = SizeConfig.safeBlockHorizontal! * 6.5;
    final double fontSize1 = SizeConfig.safeBlockHorizontal! * 5.5;
    final double fontSize2 = SizeConfig.safeBlockHorizontal! * 2.5;

    return Container(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: SizeConfig.screenWidth! * 1 / 2,
          height: SizeConfig.screenHeight! * 3 / 10,
          padding: EdgeInsets.only(left: 3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 2.0),
          ),
          child: FittedBox(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ' Leaderboard',
                  style: TextStyle(
                    fontSize: fontSize0,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal! * 0.7,
                ),
                for (var _count = 1; _count <= 10; _count++)
                  (dataFirestore!.scoreData[letterSelectValue!][_count-1] != '') ?
                    Text('$_count.'
                      + dataFirestore!.scoreData[letterSelectValue!][_count - 1]
                      , style: TextStyle(fontSize: fontSize1,fontFamily: fontName2,) )
                      //, overflow: TextOverflow.ellipsis,)
                      : Text( ' '/*'\n'*/, style: TextStyle(
                        fontSize: fontSize1,
                        fontFamily: fontName2,),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
