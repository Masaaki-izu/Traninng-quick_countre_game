import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final gameProvider = StateNotifierProvider((_) => Game());

class Game extends StateNotifier<int> {
  Game() : super(0);


  int _buttonCounter = 0;
  int get buttonCounter  => _buttonCounter;

  set buttonCounter(value) => {
    _buttonCounter = value,
    state = value
  };

  int _letterSelectValue = 0;
  int get letterSelectValue => _letterSelectValue;

  set letterSelectValue(value) => {
    _letterSelectValue = value,
    state = value
  };

  List<String> emptyList = [];
  List<String> emptyShuffleList = [];

  List<String> buttonListNumeral = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30'
  ];
  List<String> buttonListUppercase = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '',
    '',
    '',
    ''
  ];
  List<String> buttonListLowercase = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '',
    '',
    '',
    ''
  ];
  List<List<String>> positionsList = [
    [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30'
    ],
    [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
      '',
      '',
      '',
      ''
    ],
    [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z',
      '',
      '',
      '',
      ''
    ]
  ];

  void shufflePositoins(int selectNo) {
    emptyList = []..addAll(positionsList[selectNo]);
    emptyShuffleList = []..addAll(positionsList[selectNo]);
    emptyShuffleList.shuffle();
  }

  void increment() {
    state = _buttonCounter++;
  }

  List<int> buttonLastNumber = [
   30,//3//30,
   26,//3,//26,
   26,//3,//26,
  ];
}
