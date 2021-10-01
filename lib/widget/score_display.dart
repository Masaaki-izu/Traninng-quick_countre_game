import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_countre_game/etc/function_relation.dart';
import '../provider/play_game.dart';
import '../etc/size_config.dart';
import '../etc/cs.dart';

class ScoreDisplayWidget extends HookWidget {
  ScoreDisplayWidget({Key? key}) : super(key: key);

  final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: SizeConfig.safeBlockHorizontal! * 5.5,
      fontFamily: fontName2);
  final TextStyle textStyle0 = TextStyle(
      color: Colors.amberAccent,
      fontSize: SizeConfig.safeBlockHorizontal! * 5.5,
      fontFamily: fontName2);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final provider = useProvider(playGameProvider);
    useProvider(playGameProvider.state);

    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Table(
          children: [
            TableRow(children: [
              Center(
                child: Text(selectGame[0],
                    style: textStyle0),
              ),
              Center(
                child: Text(
                  selectGame[1],
                  style: textStyle0,
                ), //),
              ),
              Center(
                child: Text(
                  selectGame[2],
                  style: textStyle0,
                ), //),
              ),
            ]),
            TableRow(children: [
              Center(
                child: Text(
                  (provider.strNumeral1from30 !=
                      '999.99')
                      ? funcDataSCharAdd(provider.strNumeral1from30)
                      : "----",
                  style: textStyle,
                ),
              ), //),
              Center(
                child: Text(
                  (provider.strUppercaseAfromZ != '999.99')
                      ? funcDataSCharAdd(provider.strUppercaseAfromZ)
                      : "----",
                  style: textStyle,
                ),
              ),
              Center(
                child: Text(
                  (provider.strLowercaseAfromZ !=
                      '999.99')
                      ? funcDataSCharAdd(provider.strLowercaseAfromZ)
                      : "----",
                  style: textStyle,
                ),
              ), //),
            ])
          ],
        ),
      ),
    );
  }
}