import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_countre_game/pages/start.dart';
import './pages/start.dart';
import 'etc/input_storage.dart';
import 'etc/se_sound.dart';
import 'model/data_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  DataFirestore  dataFirestore =  DataFirestore();
  await dataFirestore.rankingReadData();
  SeSound soundIns = SeSound();

  runApp(
    ProviderScope(
      child: MyApp(dataFirestore: dataFirestore,soundIns: soundIns,),
    ),
  );
}

class MyApp extends StatelessWidget{
  final DataFirestore? dataFirestore;
  final SeSound? soundIns;
  //final InputStorage? inputStorage;
  MyApp({Key? key,this.dataFirestore,this.soundIns,/*this.inputStorage*/}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StartApp(dataFirestore: dataFirestore,soundIns: soundIns,inputStorage: InputStorage(),),
    );
  }
}