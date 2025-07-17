import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class ArticleListResponse {
  final int errorCode;
  final String errorMsg;
  final ArticlePage data;

  ArticleListResponse({
    required this.errorCode,
    required this.errorMsg,
    required this.data,
  });

  factory ArticleListResponse.fromJson(Map<String, dynamic> json) {
    return ArticleListResponse(
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
      data: ArticlePage.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errorCode': errorCode,
      'errorMsg': errorMsg,
      'data': data.toJson(),
    };
  }
}

class ArticlePage {
  final int curPage;
  final List<Article> datas;
  final int offset;
  final bool over;
  final int pageCount;
  final int size;
  final int total;

  ArticlePage({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory ArticlePage.fromJson(Map<String, dynamic> json) {
    return ArticlePage(
      curPage: json['curPage'],
      datas: (json['datas'] as List).map((e) => Article.fromJson(e)).toList(),
      offset: json['offset'],
      over: json['over'],
      pageCount: json['pageCount'],
      size: json['size'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'curPage': curPage,
      'datas': datas.map((e) => e.toJson()).toList(),
      'offset': offset,
      'over': over,
      'pageCount': pageCount,
      'size': size,
      'total': total,
    };
  }
}

class Article with ChangeNotifier {
  final int id;
  final String title;
  final String link;
  final String niceDate;
  final String shareUser;
  final String author;
  final int zan;
  bool _collect;

  bool get collect => _collect;

  set collect(bool value) {
    _collect = value;
    notifyListeners();
  }

  final String chapterName;
  final String superChapterName;
  final int publishTime;
  final int type;

  Article({
    required this.id,
    required this.title,
    required this.link,
    required this.niceDate,
    required this.shareUser,
    required this.author,
    required this.zan,
    required bool collect,
    required this.chapterName,
    required this.superChapterName,
    required this.publishTime,
    required this.type,
  }) : _collect = collect;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      link: json['link'] as String,
      niceDate: json['niceDate'] as String,
      shareUser: (json['shareUser'] ?? '') as String,
      author: (json['author'] ?? '') as String,
      zan: json['zan'] as int,
      collect: json['collect'] == true,
      chapterName: json['chapterName'] as String,
      superChapterName: json['superChapterName'] as String,
      publishTime: json['publishTime'] as int,
      type: json['type'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'link': link,
      'niceDate': niceDate,
      'shareUser': shareUser,
      'author': author,
      'zan': zan,
      'collect': collect,
      'chapterName': chapterName,
      'superChapterName': superChapterName,
      'publishTime': publishTime,
      'type': type,
    };
  }
}
