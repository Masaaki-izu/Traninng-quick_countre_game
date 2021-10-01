import 'package:hooks_riverpod/hooks_riverpod.dart';

final playGameProvider = StateNotifierProvider((_) => PlayGame());

class PlayGame extends StateNotifier<String> {
  PlayGame() : super('');

  String _strNumeral1from30 = '999.99';
  String _strUppercaseAfromZ = '999.99';
  String _strLowercaseAfromZ = '999.99';

  String get strNumeral1from30 => _strNumeral1from30;
  String get strUppercaseAfromZ => _strUppercaseAfromZ;
  String get strLowercaseAfromZ => _strLowercaseAfromZ;

  set strNumeral1from30(String s) {
       state  = s;
          _strNumeral1from30 =  s;
  }
  set strUppercaseAfromZ(String s) {
      state = s;
          _strUppercaseAfromZ = s;
  }
  set strLowercaseAfromZ(String s) {
      state = s;
          _strLowercaseAfromZ = s;
  }
}

