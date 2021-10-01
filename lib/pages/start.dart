import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_countre_game/etc/se_sound.dart';
import 'package:quick_countre_game/model/data_firestore.dart';
import 'package:quick_countre_game/provider/input_name_provider.dart';
import '../etc/cs.dart';
import '../etc/size_config.dart';
import '../provider/game.dart';
import '../pages/game.dart';
import '../etc/backgroud_image_display.dart';
import '../widget/game_display_explanation.dart';
import '../widget/game_select.dart';
import 'input_name.dart';
import '../widget/mycustom_outline_button.dart';
import '../widget/ranking_display.dart';
import '../widget/score_display.dart';
import '../widget/title_widget.dart';

class StartApp extends HookWidget {
  final SeSound? soundIns;
  final DataFirestore? dataFirestore;
  final String? inputData;

  StartApp({Key? key, this.inputData, this.dataFirestore, this.soundIns})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      SystemChrome.setEnabledSystemUIOverlays([]);

      return () => soundIns?.dispose();
    }, const []);

    SizeConfig().init(context);
    final double size = SizeConfig.safeBlockHorizontal! * 3.0;
    final startGameProvider = useProvider(gameProvider);
    useProvider(gameProvider.state);
    final inputpro = useProvider(inputNameProvider);
    useProvider(inputNameProvider.state);

    return Stack(
      children: [
        BackgroundImageDisplay(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    (inputpro.stringInputName == '')// 名前など入力済みか
                        ? firstScreen()
                        : secondScreen(context, startGameProvider,
                            inputpro.stringInputName),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GameDisplayExplanation(
                          safeBlockHorizontal: SizeConfig.blockSizeHorizontal,
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 0.4,
                        ),
                        RankingDisplay(
                            dataFirestore: dataFirestore,
                            letterSelectValue:
                                startGameProvider.letterSelectValue),
                      ],
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '2021.1.1',
                          textAlign: TextAlign.right,
                          style:
                              TextStyle(fontSize: size, fontFamily: fontName2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void start(BuildContext context, Game provider, String inputName) {
    provider.shufflePositoins(provider.letterSelectValue); //表示文字のシャッフル
    // ボタン押下のタイミングで効果音を再生
    soundIns?.playSe(SeSoundIds.sound_effect1); //さぁ行くぞ

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameApp(
          soundIns: soundIns, //startIns: soundIns,
          inputName: inputName,
          dataFirestore: dataFirestore,
        ),
      ),
    );
  }

  Widget secondScreen(BuildContext context, Game provider, String inputName) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 0.1,
          ),
          ScoreDisplayWidget(),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          TitleWidget(safeBlockHorizontal: SizeConfig.blockSizeHorizontal),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 0.5,
          ),
          InputNameWidget(
            dataFirestore: dataFirestore,
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          GameSelectWidget(
            soundIns: soundIns,
          ), //startIns: _soundIns),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          MyCustomOutlineButton(
              textDisplay: 'PLAY!',
              colorDisplay: Colors.redAccent.withOpacity(0.3),
              onCallback: () => start(context, provider, inputName),
              width: SizeConfig.screenWidth! * 0.8,
              fontSizeChar: SizeConfig.blockSizeHorizontal! * 10.0,
              fontFamilyChar: fontName2),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 3.4,
          ),
        ],
      ),
    );
  }

  Widget firstScreen() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 0.1,
          ),
          ScoreDisplayWidget(),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          TitleWidget(safeBlockHorizontal: SizeConfig.blockSizeHorizontal),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 0.5,
          ),
          InputNameWidget(dataFirestore: dataFirestore),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 26.9,
          ),
        ],
      ),
    );
  }
}
