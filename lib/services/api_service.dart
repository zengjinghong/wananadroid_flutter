import 'dart:convert';

import 'package:wananadroid_flutter/app/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String? _cookie = ""; // 内存保存Cookie

  /// 登录
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': username,
        'password': password,
      },
    );
    // 获取响应头 Set-Cookie
    final rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      _cookie = _parseCookie(rawCookie);
      print('保存的 cookie: $_cookie}');
    }

    return _handleResponse(response);
  }

  /// 注册
  static Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String repassword,
  }) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.register);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': username,
        'password': password,
        'repassword': repassword,
      },
    );

    return _handleResponse(response);
  }

  /// 首页 banner
  static Future<Map<String, dynamic>> banner() async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.banner);
    print('首页 banner url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  /// 文章列表
  static Future<Map<String, dynamic>> articles(int page) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.homePageArticle}$page/json");
    print('请求文章列表 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  /// 收藏文章
  static Future<Map<String, dynamic>> collect(int id) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.collectArticle}$id/json");
    print('收藏文章 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.post(url, headers: headers);
    return _handleResponse(response);
  }

  /// 取消收藏文章
  static Future<Map<String, dynamic>> uncollect(int id) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.uncollectArticel}$id/json");
    print('取消收藏文章 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.post(url, headers: headers);
    return _handleResponse(response);
  }

  /// 获取体系列表数据
  static Future<Map<String, dynamic>> loadTreeList() async {
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.tree}");
    print('体系列表数据 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  /// 获取体系下的文章
  static Future<Map<String, dynamic>> loadTreeChildList(
      int page, int cid) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.homePageArticle}$page/json?cid=$cid");
    print('获取体系下的文章 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  /// 获取导航数据
  static Future<Map<String, dynamic>> loadNaviData() async {
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.navi}");
    print('获取导航数据 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  /// 获取项目分类数据
  static Future<Map<String, dynamic>> loadProjectCategory() async {
    final url =
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.projectCategory}");
    print('获取导航数据 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  /// 获取项目文章列表数据
  static Future<Map<String, dynamic>> loadProjectList(int page, int cid) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.projectList}$page/json?cid=$cid");
    print('获取体系下的文章 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  /// 退出登录
  static Future<Map<String, dynamic>> logout() async {
    final url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.logout}");
    print('退出登录 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    _cookie = null;
    return _handleResponse(response);
  }

  /// 我的收藏页面
  static Future<Map<String, dynamic>> collectList(int page) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.collectList}$page/json");
    print('我的收藏页面 url 为: $url');
    final headers = <String, String>{};
    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
    }
    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }


  /// 搜索
  static Future<Map<String, dynamic>> search({
    required int page,
    required String key,
  }) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.searchForKeyword}$page/json");
    print('我的搜索 url 为: $url');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Cookie': _cookie!},
      body: {
        'k': key,
      },
    );
    print('我的搜索 response body 为: ${response.body}');

    return _handleResponse(response);
  }

  /// 通用处理响应
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      print("请求结果为: ${response.body}");
      return jsonDecode(response.body);
    } else {
      throw Exception('请求失败：${response.statusCode}');
    }
  }


  /// 解析cookie，去掉后面的属性，只保留key=value部分
  static String _parseCookie(String rawCookie) {
    // rawCookie格式可能是： "JSESSIONID=xxxx; Path=/; HttpOnly"
    return rawCookie.split(';').first;
  }
}
