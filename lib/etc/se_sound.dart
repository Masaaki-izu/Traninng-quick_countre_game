import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'dart:io';
import 'cs.dart';

enum SeSoundIds {
  sound_effect0,
  sound_effect1,
  sound_effect2,
  sound_effect3,
  sound_effect4,
}
//効果音など再生
class SeSound {
  String os = Platform.operatingSystem;
  bool isIOS = Platform.isIOS;
  late Soundpool _soundPool;

  final Map<SeSoundIds, int> _seContainer = Map<SeSoundIds, int>();
  final Map<int, int> _streamContainer = Map<int, int>();

  SeSound() {
    // インスタンス生成
    this._soundPool = Soundpool.fromOptions(options: SoundpoolOptions(
        streamType: StreamType.music,
        maxStreams: 5 // 5音同時発音に対応させる
    ));
    // 以降、非同期で実施
        () async {
      // 読み込んだ効果音をバッファに保持
      var soundEffect1Id = await rootBundle.load(soundData[0]).then((value) => this._soundPool.load(value));
      var soundEffect2Id = await rootBundle.load(soundData[1]).then((value) => this._soundPool.load(value));
      var soundEffect3Id = await rootBundle.load(soundData[2]).then((value) => this._soundPool.load(value));
      var soundEffect4Id = await rootBundle.load(soundData[3]).then((value) => this._soundPool.load(value));
      var soundEffect5Id = await rootBundle.load(soundData[4]).then((value) => this._soundPool.load(value));
      // バッファに保持した効果音のIDを以下のコンテナに入れておく
      this._seContainer[SeSoundIds.sound_effect0] = soundEffect1Id;
      this._seContainer[SeSoundIds.sound_effect1] = soundEffect2Id;
      this._seContainer[SeSoundIds.sound_effect2] = soundEffect3Id;
      this._seContainer[SeSoundIds.sound_effect3] = soundEffect4Id;
      this._seContainer[SeSoundIds.sound_effect4] = soundEffect5Id;
      // 効果音を鳴らしたときに保持するためのstreamIdのコンテナを初期化
      // 対象の効果音を強制的に停止する際に使用する
      this._streamContainer[soundEffect1Id] = 0;
      this._streamContainer[soundEffect2Id] = 0;
      this._streamContainer[soundEffect3Id] = 0;
      this._streamContainer[soundEffect4Id] = 0;
      this._streamContainer[soundEffect5Id] = 0;
    }();
  }

  // 効果音を鳴らすときに本メソッドをEnum属性のSeSoundIdsを引数として実行する
  void playSe(SeSoundIds ids) async {
    // 効果音のIDを取得
    var seId = this._seContainer[ids];
    if (seId != null) {
      // 効果音として存在していたら、以降を実施
      // streamIdを取得
      var streamId = this._streamContainer[seId] ?? 0;
      if (streamId > 0 && isIOS) {
        // streamIdが存在し、かつOSがiOSだった場合、再生中の効果音を強制的に停止させる
        // iOSの場合、再生中は再度の効果音再生に対応していないため、ボタン連打しても再生されないため
        await _soundPool.stop(streamId);
      }
      // 効果音のIDをplayメソッドに渡して再生処理を実施
      // 再生処理の戻り値をstreamIdのコンテナに設定する
      this._streamContainer[seId] = await _soundPool.play(seId);
    } else {
      print("se resource not found! ids: $ids");
    }
  }

  Future<void> dispose() async {
    // 終了時の後始末処理
    await _soundPool.release();
    _soundPool.dispose();
    return Future.value(0);
  }

}