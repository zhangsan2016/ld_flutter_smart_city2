

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/common/event_bus.dart';
import 'package:ldfluttersmartcity2/utils/search_services.dart';

class SearchItemView extends StatefulWidget {
  final bool isHisSearch ;
  /// 是否允许删除
  const SearchItemView({this.isHisSearch});
  @override
  _SearchItemViewState createState() => _SearchItemViewState();
}

class _SearchItemViewState extends State<SearchItemView> {
  /// 历史搜索词
  List<dynamic> hisKeywords = [] ;
  /// 推荐搜索词-大家都在搜
  List<dynamic> recommondKeywords = [
    '推荐1',
    '推荐2',
    '推荐3',
    '推荐4',
  ];
  /// 异步订阅管理
  StreamSubscription _searchDelSubscription;
  @override
  void initState(){
    print('SearchItemView  initState  ');

    super.initState();
    _getHisKeywords();
    /// 监听删除事件
    _searchDelSubscription = eventBus.on<DelSearchKeyEvent>().listen((event){
      this._delHisKeywords(event.keywords);
    });
  }

  /// 之所以定义为async，因为后续需要改造为从SharedPreferences本地获取搜索历史
  Future<void> _getHisKeywords() async {

    print('_getHisKeywords 执行');

    List his = await SearchServices.getHistoryList();
    for(int j=his.length-1; j >= 0;j--){
      hisKeywords.add(his[j]);
    }
    /// 刷新状态
    setState(() {});
    return hisKeywords;
  }

  /// 之所以定义为async，因为后续需要改造为从SharedPreferences本地获删除
  Future<void> _delHisKeywords(String keywords) async {

    if(this.hisKeywords.isNotEmpty && this.hisKeywords.contains(keywords)){
      this.hisKeywords.remove(keywords);

      // 更新内存中的数据
      List his = [];
      for(int j=hisKeywords.length-1; j >= 0;j--){
        his.add(hisKeywords[j]);
      }
      SearchServices.upHistoryData(his);
      /// 刷新状态
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    print('SearchItem SearchItem build 执行');
    List<dynamic> items = widget.isHisSearch ? hisKeywords : recommondKeywords;
    return Padding(padding: EdgeInsets.all(10),
        child: Container(
          child: Wrap(
            spacing: 10,
            children: items.map((item) {
              /// 构造Item widget
              return SearchItem(title: item, isHisSearch: widget.isHisSearch,);
            }).toList(),
          ),
        )
    );
  }
  @override
  void dispose(){
    super.dispose();
    /// 取消监听，节省系统资源
    _searchDelSubscription.cancel();
  }
}


class SearchItem extends StatefulWidget {
  @required
  final String title;
  final bool isHisSearch;
  const SearchItem({Key key, this.title, this.isHisSearch}) : super(key: key);
  @override
  _SearchItemState createState() => _SearchItemState(isHisSearch: this.isHisSearch);
}

class _SearchItemState extends State<SearchItem> {
  bool isHisSearch;
  _SearchItemState({this.isHisSearch});

  @override
  Widget build(BuildContext context) {

    print('SearchItem SearchItem _SearchItemViewState 执行');

    /// 圆角处理
    RoundedRectangleBorder shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
    );
    return Container(
      child: InkWell(
        onTap: () {
          /// 点击搜索词，发射一个搜索事件，让接收方开始搜索结果
          eventBus.fire(SearchEvent(widget.title));
        },
        /// 历史搜索VIEW, 允许对搜索词进行删除操作
        child: widget.isHisSearch ? Chip(
          onDeleted: (){
            /// 向事件总线发射一个删除搜索关键词事件
            eventBus.fire(DelSearchKeyEvent(widget.title));
          },
          label: Text(widget.title),
          shape: shape,
        ) :
        /// 大家都在搜索VIEW， 不允许对搜索词删除操作
        Chip(
          label: Text(widget.title),
          shape: shape,
        ),
      ),
    );
  }
}