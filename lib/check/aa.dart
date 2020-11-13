

import 'dart:convert';

import 'package:ldfluttersmartcity2/entity/json/device_list.dart';

void main() {


          Map companys1 = new Map();
          companys1['first'] = 15615.54;
          companys1['second'] = '查看';
          companys1['fifth'] = '控制';



  /*        companys1.keys.map((item){
           print('${item}');
          }).toList();*/

          companys1.values.map((item){
            print('${item}');
          }).toList();

          print('leng = ${companys1.length}');

          print('${companys1.isEmpty}');
          companys1 = new Map();

}


