import 'package:state_notifier/state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final inputNameProvider = StateNotifierProvider((ref) => InputNameProvider());

class InputNameProvider extends  StateNotifier<String>{
  InputNameProvider() : super('');

  String _stringInputName = '';
  String  get stringInputName => _stringInputName;

  set stringInputName(String name) {
    _stringInputName = name;
    state = name;
  }
  void inputName(String name) {
    state = name;
    stringInputName = name;
  }
}




