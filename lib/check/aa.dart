

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

  var  lampsGroup = <String, List<String>>{};
  var list = ['sdf', 'sdf'];
  var list2 = ['123', '456'];
  lampsGroup['未分组'] = list;
  lampsGroup['未分组2'] = list2;


  List<String> aa = lampsGroup.keys.map((item){
    List<String> c = lampsGroup[item];
    print('${item}');
  }).toList();


  List<String> keys = lampsGroup.keys.toList();


  String c;
  print('c = ${c.isNotEmpty}');


}
