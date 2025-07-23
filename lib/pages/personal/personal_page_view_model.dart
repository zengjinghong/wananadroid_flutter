import 'package:flutter/material.dart';
import 'package:wananadroid_flutter/models/empty_response.dart';

import '../../services/api_service.dart';

class PersonalPageViewModel extends ChangeNotifier {
  // 调用登录接口，发送用户名和密码，等待响应并转换为模型对象
  Future<bool> logout() async {
    final response = await ApiService.logout();
    final result = EmptyResponse.fromJson(response);
    return result.success;
  }
}
