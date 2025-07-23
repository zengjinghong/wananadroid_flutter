import 'package:flutter/material.dart';

import '../../models/collect_list_response.dart';
import '../../services/api_service.dart';

class CollectListPageViewModel extends ChangeNotifier {
  // 文章列表数据（私有）
  List<CollectDetail> _collectDetailList = [];

  // 对外暴露文章列表
  List<CollectDetail> get collectDetailList => _collectDetailList;

  // 加载文章数据，page 为页码（0 表示首页刷新）
  Future<void> loadCollectList(int page) async {
    // 调用 API 获取文章列表数据
    final response = await ApiService.collectList(page);

    // 解析响应数据中的文章列表
    final newList = CollectResponse.fromJson(response).data!.datas;

    if (page == 0) {
      // 如果是第一页，重置整个文章列表
      _collectDetailList = newList;
    } else {
      // 否则追加到原有列表后
      _collectDetailList.addAll(newList);
    }

    // 通知 UI 更新
    notifyListeners();
  }
}
