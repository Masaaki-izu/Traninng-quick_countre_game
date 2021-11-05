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
    final double fontSize0 = SizeConfig.safeBlockHorizontal! * 4.0 ;
    final double fontSize1 = SizeConfig.safeBlockHorizontal! * 3.5;

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, right: 7.0, bottom: 0.0, left: 0.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: SizeConfig.screenWidth! * 1 / 2,
            height: (SizeConfig.screenHeight! * SizeConfig.screenAspectRatio!)/ 1.6 ,
            padding: EdgeInsets.only(left: 5.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2.0),
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal! * 0.8,
                  ),
                  Text(
                    ' Leaderboard',
                    style: TextStyle(
                      fontSize: fontSize0 ,fontFamily: fontName2
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal! * 1.3,
                  ),
                  for (var _count = 1; _count <= 10; _count++)
                    (dataFirestore?.scoreData[letterSelectValue!][_count - 1] != '') ?
                    Text('$_count.' + dataFirestore!.scoreData[letterSelectValue!][_count - 1]
                        , style: TextStyle(
                          fontSize: fontSize1, fontFamily: fontName2,))
                        : Text(' ', style: TextStyle(fontSize: fontSize1, fontFamily: fontName2,),),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
