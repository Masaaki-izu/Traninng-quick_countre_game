import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_countre_game/etc/input_storage.dart';
import 'package:quick_countre_game/etc/se_sound.dart';
import '../provider/game.dart';
import '../etc/cs.dart';
import '../etc/size_config.dart';

class GameSelectWidget extends HookWidget {
  final InputStorage? inputStorage;
  final SeSound? soundIns;
  GameSelectWidget({Key? key,this.soundIns,this.inputStorage }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final provider = useProvider(gameProvider);
    useProvider(gameProvider.state);
    List<Color> colorData = [Colors.blue, Colors.blue, Colors.blue, Colors.blue];
    colorData[provider.letterSelectValue] = Colors.red;

    return Container(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.only(right:14.0,left:14.0,bottom:10.0,top:10.0 ),
                  side: BorderSide(width: 3.0, color: colorData[0]),//2]),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0))
              ),
              onPressed: () async => {
                //provider.letterSelectValue = 0,//2,
                await soundIns?.playSe(SeSoundIds.sound_game_select),
                inputStorage?.writeGameNumber('0'),
                provider.letterSelectValue = 0,
              },
              child: Text(
                selectGame[0],
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 9.5,
                  color: Colors.white,
                  fontFamily: fontName2,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal! * 0.1),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.only(right:14.0,left:14.0,bottom:10.0,top:10.0 ),
                  side: BorderSide(width: 3.0, color: colorData[1]),//2]),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0))
              ),
              onPressed: () async => {
                await soundIns?.playSe(SeSoundIds.sound_game_select),
                inputStorage?.writeGameNumber('1'),
                provider.letterSelectValue = 1,//2,
              },
              child: Text(
                selectGame[1],
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 9.5,
                  color: Colors.white,
                  fontFamily: fontName2,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal! * 0.1),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.only(right:14.0,left:14.0,bottom:10.0,top:10.0 ),
                  side: BorderSide(width: 3.0, color: colorData[2]),//3]),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0))
              ),
              onPressed: () async => {
                await soundIns?.playSe(SeSoundIds.sound_game_select),
                inputStorage?.writeGameNumber('2'),
                provider.letterSelectValue = 2,//3,
              },

              child: Text(
                selectGame[2],
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 9.5,
                  color: Colors.white,
                  fontFamily: fontName2,),
              ),
            ),
          ],
        ),
    );
  }
}