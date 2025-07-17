import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/services/api_service.dart';

import '../../models/project_article_response.dart';
import '../../models/project_category_response.dart';

class ProjectPageViewModel extends ChangeNotifier {
  List<ProjectCategory> _projectCategoryList = [];

  List<ProjectCategory> get projectCategoryList => _projectCategoryList;

  List<ProjectArticle> _projectArticleList = [];

  List<ProjectArticle> get projectArticleList => _projectArticleList;

  Future<void> loadProjectCategory() async {
    final response = await ApiService.loadProjectCategory();

    _projectCategoryList = ProjectCategoryResponse.fromJson(response).data;

    notifyListeners();
  }

  // 加载文章数据，page 为页码（0 表示首页刷新）
  Future<void> loadProjectArticles(int page, int cid) async {
    // 调用 API 获取文章列表数据
    final response = await ApiService.loadProjectList(page, cid);

    // 解析响应数据中的文章列表
    final newList = ProjectArticleResponse.fromJson(response).data.datas;

    if (page == 1) {
      // 如果是第一页，重置整个文章列表
      _projectArticleList = newList;
    } else {
      // 否则追加到原有列表后
      _projectArticleList.addAll(newList);
    }

    // 通知 UI 更新
    notifyListeners();
  }
}
