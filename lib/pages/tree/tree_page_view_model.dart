import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/services/api_service.dart';

import '../../models/chapter_response.dart';

class TreePageViewModel extends ChangeNotifier {
  List<Chapter> _chapterList = [];

  List<Chapter> get chapterList => _chapterList;

  /// 获取体系数据
  Future<void> loadTree() async {
    final response = await ApiService.loadTreeList();

    _chapterList = ChapterResponse.fromJson(response).data;

    notifyListeners();
  }
}
