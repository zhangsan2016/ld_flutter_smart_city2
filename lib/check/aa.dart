

import 'dart:convert';

import 'package:ldfluttersmartcity2/entity/json/device_list.dart';

void main() {
/*  final random = Random();

  var a = 5;
  // double b = a is int  ;
  print(a);

  var c = null;

  double gg = c;
  int ll = 99;
  print("xx $gg  $ll");

  Project project = new Project();
  project.title = 'sdfdsf';

  String str = project.toJson().toString();

  print('str = ' + str);


  Map<String, dynamic> map = project.toJson();

  print(json.encode(map));*/

/*  List testList3 = List<String>();
  testList3.add("哈哈哈");
print('${  testList3.length}');

  var morePlanets = new List<String>.from(testList3);

  print('morePlanets $morePlanets');
  testList3[0] = "sdfjdskf";
  print('morePlanets $morePlanets');
  print('testList3 $testList3');*/

  /*DateTime victoryDay = new DateTime(1585702939556);//
  print(victoryDay.toString());

  //timestamp 为毫秒时间戳
  var date = new DateTime.fromMicrosecondsSinceEpoch(1585702939556);

//unix_timestamp 为unix timestamp
  var date1 = new DateTime.fromMicrosecondsSinceEpoch(1585702939556*1000);

  print('${date1.toString()}');


  var aa ;
  print('${aa.toString()}');


  var time =null;
  if(time != null){
    int t = int.parse(time.toString());
    print('${t}');
  }else{
    print('object');
  }

  String value ='';
  if(value.isEmpty){
    print('非空');
  }*/


  
/*  List<Device> de = [];
  print(' ${de.length}');
  de.add(null);
  print('${de.length}');

  de.insert(0, new Device());

  print('${de.length}');
  print('${de[0] == null} ${de[1] == null}');

 var historys = ['sdf','sdfsdfsdfsd','sdfdsfdddddd'];
  print(historys.length);

  historys.add('s996');
  for(int j=historys.length-1; j >= 0;j--){
    print('xxx ${historys[j]}');
  }*/


/*  StringBuffer builder = new StringBuffer();
  builder.write("sdfdsf");
  builder.write("sdfdsf2");
  builder.write("sdfds3");
  builder.write("sdfds4");

  print('${builder.toString()}');*/



 List<String> c = [];
 c.add('sdfsdfdsfsdf');
 c.add('4554sdfsdf');


String myjs =  json.encode(c);
 print('$myjs');

 List list = json.decode(myjs);

 print('${list[1]}');

 list.add("value1");
 list.add("value2");

 print('${list[3]}  size : ${list.length}');
 print('${list.toString()}');
  list.insert(0, '9966');
 print('${list[3]}  size : ${list.length}');
 print('${list.toString()}');




 }


