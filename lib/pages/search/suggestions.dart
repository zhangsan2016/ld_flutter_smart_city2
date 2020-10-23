
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/pages/search/search_item_view.dart';

/// 搜索词建议widget
class Suggestions extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromARGB(240, 11, 29, 77),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
    /*      Container(
            child: Text(
                '大家都在搜'
            ),
          ),
          SearchItemView(isHisSearch: false,), // isHisSearch 是否历史搜索词View*/
          Container(
            child: Text(
                '历史搜索记录',style: TextStyle(color: Colors.white),
            ),
          ),
          SearchItemView(isHisSearch: true,),
        ],
      ),
    );
  }
}
