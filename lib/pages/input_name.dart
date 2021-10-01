import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_countre_game/model/data_firestore.dart';
import '../provider/input_name_provider.dart';
import '../provider/play_game.dart';
import '../etc/size_config.dart';
import '../etc/cs.dart';

const int  inputCharMax = 10;

class InputNameWidget extends HookWidget {
  final DataFirestore? dataFirestore;
  InputNameWidget({Key? key, this.dataFirestore }) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final inputpro = useProvider(inputNameProvider);
    useProvider(inputNameProvider.state);
    final playGame = useProvider(playGameProvider);
    useProvider(playGameProvider.state);

    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showInputDialog(inputpro,context,
                  SizeConfig.screenWidth!, SizeConfig.safeBlockHorizontal!,playGame );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: SizeConfig.safeBlockVertical! * 1.0,
                ),
                Container(
                  width: SizeConfig.screenWidth! * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      inputpro.stringInputName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.safeBlockHorizontal! * 5.0,
                        fontFamily: fontName2,
                      ),
                      textAlign: TextAlign.center,
                      //overflow: TextOverflow.ellipsis,//
                    ),
                  ),
                ),
                Icon(Icons.touch_app_sharp,
                    color: Colors.white,
                    size: SizeConfig.safeBlockHorizontal! * 5.0,
                    textDirection: TextDirection.rtl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInputDialog(inputpro,BuildContext context,
      double screenWidth, double safeBlockHorizontal, playGame ) async {

    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          AlertDialog(
            contentPadding: EdgeInsets.all(8.0),
            content: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffffffff),
                        hintText: 'Enter NickName',
                        hintMaxLines: 20,
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: safeBlockHorizontal * 6.5,
                          fontFamily: fontName2,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 54.0),
                      ),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: safeBlockHorizontal * 5.5,
                      ),
                      maxLength: inputCharMax , //15
                      //maxLines: null,
                      controller: textEditingController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(inputCharMax),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                        fontSize: safeBlockHorizontal * 6.0,
                        color: Colors.white,
                        fontFamily: fontName2),
                  ),
                  onPressed: () {
                    Navigator.pop(context, '');
                    SystemChrome.restoreSystemUIOverlays();
                  }),
              TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontSize: safeBlockHorizontal * 6.0,
                        color: Colors.white,
                        fontFamily: fontName2),
                  ),
                  onPressed: () {
                    var name = textEditingController.text;
                    if (name.length > inputCharMax) {
                     name = name.substring(0, inputCharMax);
                    }
                    // if (name.length > 15) {
                    //   name = name.substring(0, 15);
                    // }
                    Navigator.pop(context, name);
                    SystemChrome.restoreSystemUIOverlays();
                  })
            ],
          ),
    ).then((value) {
      if (value != '') {
        inputpro.inputName(value);
        dataFirestore?.nameCheck(collection: 'QuickCuntre',inputName: value,playGame: playGame);
      }
    });
  }
}



