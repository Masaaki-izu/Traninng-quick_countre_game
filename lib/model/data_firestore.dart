import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_countre_game/etc/cs.dart';
import 'package:quick_countre_game/etc/function_relation.dart';
import 'package:quick_countre_game/provider/play_game.dart';

class DataFirestore{

  List<List<String>> scoreData = [
    [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ],
    [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ],
    [
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    ],
  ];

  Map<String , dynamic> testdata = {
    'numeral': 999.99,
    'lowercase': 999.99,
    'uppercase': 999.99,
  };
  bool? isFlag = true;

  Future<void>setData(String? collection,String? id ,Map<String,dynamic> data) async{
    await FirebaseFirestore.instance.collection(collection!).doc(id).set(data);
  }

  Future<void>upData(String? collection,String? name, Map<String,dynamic> data) async{
    var colectIns = FirebaseFirestore.instance.collection(collection!).doc(name); //where('name', isEqualTo: name);
    await colectIns.update(data);
  }

  Future<void>nameCheck({String? collection, String? inputName,PlayGame? playGame})  async{
    var colectIns = await FirebaseFirestore.instance.collection(collection!).where('name', isEqualTo: inputName).get();
    bool isAruka = false;

    colectIns.docs.forEach((element) {
      if  (element.data().isNotEmpty) { isAruka = true; /* print('element ' + element.data().toString() ) ; */
          Map<String, dynamic> data = element.data();
          if (inputName == data['name']) {
            playGame?.strNumeral1from30 = data['numeral'].toString();
            playGame?.strUppercaseAfromZ = data['uppercase'].toString();
            playGame?.strLowercaseAfromZ = data['lowercase'].toString();
          }
      }
    });
    if (isAruka == false ) {
      Map<String, dynamic> addData = {'name':inputName};
      testdata.addAll(addData);
      setData(collection,inputName,testdata);
      playGame?.strNumeral1from30 = testdata['numeral'].toString();
      playGame?.strUppercaseAfromZ = testdata['uppercase'].toString();
      playGame?.strLowercaseAfromZ = testdata['lowercase'].toString();
    }
  }

  Future<void>readData({String? collection,String? fieldName,int? letterSelectValue}) async{
    int _count = 0;
    var colectIns = await FirebaseFirestore.instance.collection(collection!).orderBy(fieldName!,descending: false ).get();

    colectIns.docs.forEach((element) {
      Map<String, dynamic> data = element.data();
      if (data[fieldName] != 999.99 ){
        if (_count < 10) this.scoreData[letterSelectValue!][_count] = data['name'] + ':' + funcDataSCharAdd(data[fieldName].toString());
      }
      _count++;
    });
  }

  Future<void>rankingReadData() async{
    for(var _count = 0; _count < 3 ;_count++)
      await readData(collection:collectionName,fieldName: fieldListName[_count],letterSelectValue:_count);
    isFlag = false;
  }
}
