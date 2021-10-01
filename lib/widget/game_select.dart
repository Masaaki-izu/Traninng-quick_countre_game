import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_countre_game/etc/se_sound.dart';
import '../provider/game.dart';
import '../etc/cs.dart';
import '../etc/size_config.dart';

class GameSelectWidget extends HookWidget {
  final SeSound? soundIns;
  GameSelectWidget({Key? key,this.soundIns }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final provider = useProvider(gameProvider);
    useProvider(gameProvider.state);
    List<Color> colorData = [Colors.blue, Colors.blue, Colors.blue];
    colorData[provider.letterSelectValue] = Colors.red;
    return Container(
      child: FittedBox(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(18.0),
                  side: BorderSide(width: 3.0, color: colorData[0]),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0))
              ),
              onPressed: () {
                soundIns?.playSe(SeSoundIds.sound_game_select);
                provider.letterSelectValue = 0;
              },
              child: Text(
                selectGame[0],
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7.2,
                  color: Colors.white,
                  fontFamily: fontName2,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal! * 1.2),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(18.0),
                  side: BorderSide(width: 3.0, color: colorData[1]),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0))
              ),
              onPressed: () {
                soundIns?.playSe(SeSoundIds.sound_game_select);
                provider.letterSelectValue = 1;
              },
              child: Text(
                selectGame[1],
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7.2,
                  color: Colors.white,
                  fontFamily: fontName2,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal! * 1.2),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.all(18.0),
                  side: BorderSide(width: 3.0, color: colorData[2]),
                  //(0xffffffff)),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0))
              ),
              onPressed: () {
                soundIns?.playSe(SeSoundIds.sound_game_select);
                  provider.letterSelectValue = 2;
              },

              child: Text(
                selectGame[2],
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal! * 7.2,
                  color: Colors.white,
                  fontFamily: fontName2,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}