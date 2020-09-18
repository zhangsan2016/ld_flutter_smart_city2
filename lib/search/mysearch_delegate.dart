import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/common/event_bus.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/search/search_results.dart';
import 'package:ldfluttersmartcity2/search/suggestions.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/search_services.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

import 'auto_complete.dart';

/// 实现SearchDelegate
class MySearchDelegate extends SearchDelegate<String> {
  StreamSubscription _searchSubscription;

  var currentProject;

  MySearchDelegate(this.currentProject);

  @override
  String get searchFieldLabel => '请输入UUID或名称';

  /**
   * buildActions 返回一个Widget List, 定义搜索栏右侧的按钮
   */
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  /**
   * buildLeading 返回一个Widget，定义搜索栏左边的按钮，一般为返回按钮
   */
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
            showSuggestions(context);
          }
        } //点击时关闭整个搜索页面
        );
  }

  /**
   * buildResults 返回一个Widget用以展现搜索出来的结果
   */
  @override
  Widget buildResults(BuildContext context) {
    print('buildResults 执行');
    // 保存搜索历史记录
    SearchServices.setHistoryData(query);
    // 取消搜索侦听
    _searchSubscription.cancel();

    // 简单显示搜索结果，并未真正去请求网络，后面文章会继续讲解如何通过api查询
    return SearchResults(query,currentProject);
  }


  /**
   *  buildSuggestions 搜索的建议关键词，例如推荐热词，历史搜索词
   */
  @override
  Widget buildSuggestions(BuildContext context) {
    // 事件侦听
    _searchSubscription = eventBus.on<SearchEvent>().listen((event) {
      this.popResults(context);
      this.setSearchKeyword(event.keywords);
    });

    /// 将方法作为参数传递给子组件调用，展示使用非EventBus方式通信
    return query.isEmpty
        ? Suggestions()
        : AutoComplete(
            query, this.popResults, this.setSearchKeyword, currentProject);
  }

  /// 搜索结果展示
  void popResults(BuildContext context) {
    showResults(context);
  }

  /// 设置query
  Future<void> setSearchKeyword(String searchKeyword) async {
    query = searchKeyword;
  }
}
