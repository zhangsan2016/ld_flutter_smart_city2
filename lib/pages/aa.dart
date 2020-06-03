import 'dart:convert';
import 'dart:math';

import 'package:ldfluttersmartcity2/entity/json/project_info.dart';

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





  print('(aa?.isEmpty?aa:'' )');
String aa = null;

print((aa?.substring(1)));








  /// 检查对象或 List 或 Map 是否为空
  bool isEmpty(Object object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is List && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }

}
