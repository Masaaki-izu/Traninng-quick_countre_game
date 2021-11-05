import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'dart:io';
import 'cs.dart';

enum SeSoundIds {
  sound_game_select,
  sound_game_start,
  sound_game_success,
  sound_game_fail,
  sound_game_button_ok,
}

class SeSound {
  String os = Platform.operatingSystem;
  bool isIOS = Platform.isIOS;
  late Soundpool _soundPool;

  final Map<SeSoundIds, int> _seContainer = Map<SeSoundIds, int>();
  final Map<int, int> _streamContainer = Map<int, int>();

  SeSound() {
    this._soundPool = Soundpool.fromOptions(
        options: SoundpoolOptions(streamType: StreamType.music, maxStreams: 5));
    () async {
      var soundEffect1Id = await rootBundle
          .load(soundData[0])
          .then((value) => this._soundPool.load(value));
      var soundEffect2Id = await rootBundle
          .load(soundData[1])
          .then((value) => this._soundPool.load(value));
      var soundEffect3Id = await rootBundle
          .load(soundData[2])
          .then((value) => this._soundPool.load(value));
      var soundEffect4Id = await rootBundle
          .load(soundData[3])
          .then((value) => this._soundPool.load(value));
      var soundEffect5Id = await rootBundle
          .load(soundData[4])
          .then((value) => this._soundPool.load(value));
      this._seContainer[SeSoundIds.sound_game_select] = soundEffect1Id;
      this._seContainer[SeSoundIds.sound_game_start] = soundEffect2Id;
      this._seContainer[SeSoundIds.sound_game_success] = soundEffect3Id;
      this._seContainer[SeSoundIds.sound_game_fail] = soundEffect4Id;
      this._seContainer[SeSoundIds.sound_game_button_ok] = soundEffect5Id;

      this._streamContainer[soundEffect1Id] = 0;
      this._streamContainer[soundEffect2Id] = 0;
      this._streamContainer[soundEffect3Id] = 0;
      this._streamContainer[soundEffect4Id] = 0;
      this._streamContainer[soundEffect5Id] = 0;
    }();
  }

  Future<void> playSe(SeSoundIds ids) async {
    var seId = this._seContainer[ids];

    if (seId != null) {
      var streamId = this._streamContainer[seId] ?? 0;
      if (streamId > 0 && isIOS) {
        await _soundPool.stop(streamId);
      }
      this._streamContainer[seId] = await _soundPool.play(seId);
    } else {
      print("se resource not found! ids: $ids");
    }
  }

  Future<void> dispose() async {
    await _soundPool.release();
    _soundPool.dispose();
    return Future.value(0);
  }
}
