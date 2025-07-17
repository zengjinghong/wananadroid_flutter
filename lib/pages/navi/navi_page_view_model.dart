import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/models/navi_response.dart';
import 'package:wananadroid_flutter/services/api_service.dart';

class NaviPageViewModel extends ChangeNotifier {
  List<NaviData> _naviData = [];

  List<NaviData> get naviData => _naviData;

  /// 获取导航数据
  Future<void> loadNavi() async {
    final response = await ApiService.loadNaviData();

    _naviData = NaviResponse.fromJson(response).data;

    notifyListeners();
  }
}
