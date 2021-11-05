import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_countre_game/etc/input_storage.dart';
import 'package:quick_countre_game/etc/se_sound.dart';
import 'package:quick_countre_game/model/data_firestore.dart';
import 'package:quick_countre_game/provider/input_name_provider.dart';
import 'package:quick_countre_game/provider/play_game.dart';
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

bool fileFlag = false;

class StartApp extends HookWidget {
  final SeSound? soundIns;
  final DataFirestore? dataFirestore;
  final InputStorage? inputStorage;

  StartApp({Key? key, this.dataFirestore, this.soundIns,this.inputStorage})
      : super(key: key);

  String _inputDataDef= '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double size = SizeConfig.safeBlockHorizontal! * 3.0;
    final startGameProvider = useProvider(gameProvider);
    useProvider(gameProvider.state);//
    final _inputpro = useProvider(inputNameProvider);
    useProvider(inputNameProvider.state);
    final _playGame = useProvider(playGameProvider);

    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );
      inputStorage?.fileCheckFunc().then((value) => {
       if (value != '') firstFileCheck(value,_inputpro,_playGame,startGameProvider),
      });

      return () => {
       // if (_inputpro.stringInputName != '') inputStorage?.writeInputText('$_inputpro.stringInputName,$gameProvider.letterSelectValue'),
        soundIns?.dispose(),
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
        ),
      };
    }, const []);

    return Stack(
      children: [
        BackgroundImageDisplay(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    (_inputpro.stringInputName == '')
                        ? firstScreen()
                        : secondScreen(context, startGameProvider,
                        _inputpro.stringInputName,),
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
                          '2021.1.1 ',
                          textAlign: TextAlign.left,
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

  void firstFileCheck(String _data,_inputpro,_playGame,Game gameProvider) {//,BuildContext context) {
    var dataInput = _data.split(',');
    gameProvider.letterSelectValue = int.parse(dataInput[1]);//1;//0;
     _inputpro?.inputName(dataInput[0]);
     dataFirestore?.nameCheck(collection: 'QuickCuntre',inputName: _inputpro?.stringInputName,playGame: _playGame);
    return;
  }

  void start(BuildContext context, Game startGameProvider, String inputName) {
    startGameProvider.buttonCounter = 0;
    //startGameProvider.gameSwitch = 1;
    startGameProvider.shufflePositoins(startGameProvider.letterSelectValue);
    soundIns?.playSe(SeSoundIds.sound_game_start);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameApp(
          soundIns: soundIns,
          inputName: inputName,
          dataFirestore: dataFirestore,
        ),
      ),
    ).then((value) => {
      startGameProvider.state = 3,
    });
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
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          InputNameWidget(
            dataFirestore: dataFirestore,inputStorage: inputStorage,
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          GameSelectWidget(
            soundIns: soundIns,inputStorage: inputStorage,
          ),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          MyCustomOutlineButton(
              textDisplay: 'PLAY!',
              colorDisplay: Colors.redAccent.withOpacity(0.3),
              onCallback: () => start(context, provider, inputName),
              width: SizeConfig.screenWidth! * 0.8,
              fontSizeChar: SizeConfig.blockSizeHorizontal! * 10.5,
              fontFamilyChar: fontName2),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 5.4,
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
            height: SizeConfig.safeBlockHorizontal! * 1.5,
          ),
          InputNameWidget(dataFirestore: dataFirestore,inputStorage: inputStorage,),
          SizedBox(
            height: SizeConfig.safeBlockHorizontal! * 26.9,
          ),
        ],
      ),
    );
  }
}
