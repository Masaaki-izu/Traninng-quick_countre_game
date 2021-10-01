import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_countre_game/pages/start.dart';
import './pages/start.dart';
import 'etc/se_sound.dart';
import 'model/data_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([  //画面を縦固定
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();  //Firebase プロジェクト追加
  DataFirestore  dataFirestore =  DataFirestore(); //Firestore data のインスタンス
  await dataFirestore.allReadData();  //データ読込
  SeSound soundIns = SeSound();  //インスタンス、効果音の読込

  runApp(
    ProviderScope(
      child: MyApp(dataFirestore: dataFirestore,soundIns: soundIns,),
    ),
  );
}

class MyApp extends StatelessWidget{
  final DataFirestore? dataFirestore;
  final SeSound? soundIns;

  MyApp({Key? key,this.dataFirestore,this.soundIns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);//ステータスバーとナビゲーションバーを非表示
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StartApp(dataFirestore: dataFirestore,soundIns: soundIns,),
    );
  }
}