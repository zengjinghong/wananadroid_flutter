import 'package:flutter/material.dart';

import '../../models/articles_response.dart';
import '../../models/empty_response.dart';
import '../../services/api_service.dart';

class TreePageChildViewModel extends ChangeNotifier {
  // 文章列表数据（私有）
  List<Article> _articleList = [];

  // 对外暴露文章列表
  List<Article> get articleList => _articleList;

  // 加载文章数据，page 为页码（0 表示首页刷新）
  Future<void> loadArticles(int page, int cid) async {
    // 调用 API 获取文章列表数据
    final response = await ApiService.loadTreeChildList(page, cid);

    // 解析响应数据中的文章列表
    final newList = ArticleListResponse.fromJson(response).data.datas;

    if (page == 0) {
      // 如果是第一页，重置整个文章列表
      _articleList = newList;
    } else {
      // 否则追加到原有列表后
      _articleList.addAll(newList);
    }

    // 通知 UI 更新
    notifyListeners();
  }

  // 收藏文章（传入文章 ID），返回是否成功
  Future<bool> collect(int id) async {
    final response = await ApiService.collect(id);
    final result = EmptyResponse.fromJson(response);
    return result.success;
  }

  // 取消收藏文章（传入文章 ID），返回是否成功
  Future<bool> uncollect(int id) async {
    final response = await ApiService.uncollect(id);
    final result = EmptyResponse.fromJson(response);
    return result.success;
  }
}
