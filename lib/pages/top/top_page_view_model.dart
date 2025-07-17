import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/models/articles_response.dart';
import 'package:wananadroid_flutter/models/banner_response.dart';
import 'package:wananadroid_flutter/models/empty_response.dart';

import '../../services/api_service.dart';

// 页面数据的 ViewModel，用于管理 Banner 和文章数据
class TopPageViewModel extends ChangeNotifier {
  // Banner 数据列表（私有）
  List<BannerItem> _bannerList = [];

  // 对外暴露 Banner 数据
  List<BannerItem> get bannerList => _bannerList;

  // 文章列表数据（私有）
  List<Article> _articleList = [];

  // 对外暴露文章列表
  List<Article> get articleList => _articleList;

  // 加载 Banner 数据（调用 API，解析响应，更新状态）
  Future<void> loadBanner() async {
    // 调用 API 获取 banner 数据
    final response = await ApiService.banner();

    // 将响应数据转换为模型对象并赋值
    _bannerList = BannerResponse.fromJson(response).data;

    // 通知监听者（如 UI）更新
    notifyListeners();
  }

  // 加载文章数据，page 为页码（0 表示首页刷新）
  Future<void> loadArticles(int page) async {
    // 调用 API 获取文章列表数据
    final response = await ApiService.articles(page);

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
