import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_countre_game/etc/se_sound.dart';
import 'package:quick_countre_game/model/data_firestore.dart';
import 'package:quick_countre_game/pages/timer_text_widget.dart';
import '../provider/input_name_provider.dart';
import '../provider/timer.dart';
import '../provider/play_game.dart';
import '../etc/size_config.dart';
import '../provider/game.dart';
import '../etc/backgroud_image_display.dart';
import '../etc/cs.dart';
import '../widget/mycustom_outline_button.dart';

class GameApp extends HookWidget {
  final String? inputName;
  final DataFirestore? dataFirestore;
  final SeSound? soundIns;
  GameApp({Key? key,  this.soundIns, this.inputName,this.dataFirestore}) : super(key: key);

  // static bool? isTimeUp = false;
  // static int? playStatus = 0;
  // static int? upDataGame = 0;
  // static TimerState?  datast = TimerState.initial;
  bool? isTimeUp = false;
  int? playStatus = 0;
  int? upDataGame = 0;
  TimerState?  datast = TimerState.initial;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final playGame = useProvider(playGameProvider);
    useProvider(playGameProvider.state);
    final provider = useProvider(gameProvider);
    useProvider(gameProvider.state);
    final inputpro = useProvider(inputNameProvider);

    useEffect(() {
      isTimeUp = false;
      playStatus = 0;
      upDataGame = 0;
      context.read(timerProvider).start();
      //provider.gameSwitch = 1;
      return () => {};
    }, const []);

    final timerLeft = useProvider(timerProvider.state).timeLeft;
    final timerState = useProvider(timerStateProvider);
    useProvider(timerStateProvider.select((value) => value));//終了状態

    return Stack(
      children: <Widget>[
        BackgroundImageDisplay(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child:Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TimerTextWidget(
                          scaleSize: SizeConfig.safeBlockVertical!),
                      SizedBox(
                        width: SizeConfig.safeBlockVertical! * 0.9,
                      ),
                      MyCustomOutlineButton(
                        textDisplay: 'QUIT',
                        colorDisplay: Colors.redAccent.withOpacity(0.3),
                        onCallback: () => {
                          quitButton(
                              context, timerLeft, playGame, provider)
                        },
                        width: SizeConfig.screenWidth! * 0.4,
                        fontSizeChar: SizeConfig.blockSizeHorizontal! * 11.0,
                        fontFamilyChar: fontName2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1.0,
                  ),
                  _countRendDisplay(playGame,provider,timerLeft ,timerState ,SizeConfig.safeBlockHorizontal!,inputpro),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2.0,//6.0,
                  ),
                  _createButton(
                      context,
                      SizeConfig.screenWidth!,
                      SizeConfig.screenHeight!,
                      provider,
                      SizeConfig.safeBlockHorizontal!),
                ],
              ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _createButton( BuildContext context, double width, double height,
      Game provider, double scalingSize) {
    // アスペクト比を計算する
    final double itemHeight = (height - 24) / 2;
    final double itemWidth = width;

    return new GridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      mainAxisSpacing: 2.0,
      childAspectRatio: (itemWidth / itemHeight),
      padding: const EdgeInsets.all(3.0),//only(left:2.0,right:2.0),//all(4),

      children: provider.emptyShuffleList.map((String value) {
        return _buttonCheck( provider, context, itemWidth,itemHeight, value, scalingSize);
      }).toList(),
    );
  }

  Widget _buttonCheck( Game provider, BuildContext context, double width, double height,
      String checkNo, double scalingSize) {

    return Container(
      width: width / 7.0, //7,
      height: height * (2/3) *  (1/6) ,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),//2
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(2.5),//2.5
      ),
      margin: EdgeInsets.all(8.0), //2.5 //8.0),
      child: RawMaterialButton(
        fillColor: Colors.redAccent.withOpacity(0.3),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.5),//3.0
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),//2
          child: Text(
            checkNo,
            style: TextStyle(
                fontFamily: fontName2,
                color: Colors.white,
                fontSize: scalingSize * 10.0),//12
            //textAlign: ,//9.0
          ),
        ),
        onPressed: () {
          if (playStatus == 1 || playStatus == 2) return;
          if (checkNo == provider.emptyList[provider.buttonCounter]) {
            provider.buttonCounter++;
            if (provider.buttonCounter >=
                provider.buttonLastNumber[provider.letterSelectValue]) {
              isTimeUp = true;
              context.read(timerProvider).pause();
              playStatus = 1;
              soundIns?.playSe(SeSoundIds.sound_game_success);
            }
            else {
              soundIns?.playSe(SeSoundIds.sound_game_button_ok);
             }
          } else {
            isTimeUp = true;
            playStatus = 2;
            context.read(timerProvider).stop();
            soundIns?.playSe(SeSoundIds.sound_game_fail);
          }
        },
      ),
    );
  }


  Widget _countRendDisplay(PlayGame playGame,Game provider,String timerLeft, timerState ,double scalingSize,inputpro) {
    String _dispString = '';
    double _magnification = 16.2;
    double numeral,uppercase,lowercase;
    double scoreNow;

    try {
      scoreNow = double.parse(timerLeft);
    } catch (exception) {
      scoreNow= 999.99;
    }
    if (isTimeUp == false &&  timerState == TimerState.finished) {
      _dispString = strMessage[0];
    }
    else if (isTimeUp == false && playStatus == 0) {
      _dispString = provider.emptyList[provider.buttonCounter];
      _magnification = 16.2;
    }
    else {
      if (playStatus == 1) {
        _dispString = strMessage[1];
        _magnification = 16.2;

        switch (provider.letterSelectValue) {
          case 0:
            try {
              numeral = double.parse(playGame.strNumeral1from30);
            } catch (exception) {
              numeral = 999.99;
            }
            if (numeral > scoreNow) {
              Map<String, dynamic> upData = {
                'name': this.inputName,
                'numeral': scoreNow
              };
              dataFirestore?.upData('QuickCuntre', this.inputName,
                  upData);
              upDataGame = 1;
            }
            break;
          case 1:
            try {
              uppercase = double.parse(playGame.strUppercaseAfromZ);
            } catch (exception) {
              uppercase = 999.99;
            }
            if (uppercase > scoreNow) {
              Map<String, dynamic> upData = {
                'name': this.inputName,
                'uppercase': scoreNow
              };
              dataFirestore?.upData('QuickCuntre', this.inputName, upData);
              upDataGame = 2;
            }
            break;
          case 2:
            try {
              lowercase = double.parse(playGame.strLowercaseAfromZ);
            } catch (exception) {
              lowercase = 999.99;
            }
            if (lowercase > scoreNow) {
              Map<String, dynamic> upData = {
                'name': this.inputName,
                'lowercase': scoreNow
              };
              dataFirestore?.upData('QuickCuntre', this.inputName, upData);
              upDataGame = 3;
            }
            break;
        }
      }
      else if (playStatus == 2) {
        _dispString = strMessage[0];
      }
    }

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: scalingSize * 1.0,
          ),
          Text(
            _dispString,
            style: TextStyle(
                fontSize: scalingSize * _magnification, fontFamily: fontName2),
          ),
          SizedBox(
            height: scalingSize * 1.0,
          ),
        ],
      ),
    );
  }

  void quitButton(BuildContext context, timerLeft,
      PlayGame playGame, Game provider) async{
    if (isTimeUp == true && playStatus == 1) {
      switch (provider.letterSelectValue) {
        case 0:
          if (upDataGame == 1) {
            playGame.strNumeral1from30 = timerLeft;upDataGame = 0;
          }
          await dataFirestore?.readData(collection: collectionName,fieldName: fieldListName[0],letterSelectValue:0 );
          break;
        case 1:
          if (upDataGame == 2) {
            playGame.strUppercaseAfromZ = timerLeft;upDataGame =0;
          }
          await dataFirestore?.readData(collection: collectionName,fieldName: fieldListName[1],letterSelectValue:1 );
          break;
        case 2:
          if (upDataGame == 3) {
            playGame.strLowercaseAfromZ = timerLeft;upDataGame =0;
          }
          await dataFirestore?.readData(collection: collectionName,fieldName: fieldListName[2],letterSelectValue:2 );
          break;
      }
    }

    provider.buttonCounter = 0;
    Navigator.pop(context, true);
  }
}
