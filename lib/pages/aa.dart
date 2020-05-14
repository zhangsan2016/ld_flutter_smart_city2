import 'dart:convert';
import 'dart:math';

import 'package:ldfluttersmartcity2/entity/project_info.dart';

void main() {
  final random = Random();

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

  print(json.encode(map));



}
