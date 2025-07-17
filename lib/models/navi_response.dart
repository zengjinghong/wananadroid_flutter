import 'package:flutter/material.dart';

class NaviResponse {
  final List<NaviData> data;
  final int errorCode;
  final String errorMsg;

  NaviResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory NaviResponse.fromJson(Map<String, dynamic> json) {
    return NaviResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => NaviData.fromJson(e))
          .toList(),
      errorCode: json['errorCode'] as int,
      errorMsg: json['errorMsg'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
    'errorCode': errorCode,
    'errorMsg': errorMsg,
  };
}

class NaviData {
  final int cid;
  final String name;
  final List<NaviArticle> articles;

  NaviData({
    required this.cid,
    required this.name,
    required this.articles,
  });

  factory NaviData.fromJson(Map<String, dynamic> json) {
    return NaviData(
      cid: json['cid'],
      name: json['name'],
      articles: (json['articles'] as List<dynamic>)
          .map((e) => NaviArticle.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'cid': cid,
    'name': name,
    'articles': articles.map((e) => e.toJson()).toList(),
  };
}

class NaviArticle extends ChangeNotifier {
  final int id;
  final String title;
  final String author;
  final String link;
  final int chapterId;
  final String chapterName;
  final String superChapterName;
  final int superChapterId;
  final bool collect;
  final int publishTime;
  final String niceDate;
  final String niceShareDate;
  final String shareUser;
  bool isAdminAdd;
  final int zan;
  final int userId;
  final bool fresh;
  final String envelopePic;

  NaviArticle({
    required this.id,
    required this.title,
    required this.author,
    required this.link,
    required this.chapterId,
    required this.chapterName,
    required this.superChapterName,
    required this.superChapterId,
    required this.collect,
    required this.publishTime,
    required this.niceDate,
    required this.niceShareDate,
    required this.shareUser,
    required this.isAdminAdd,
    required this.zan,
    required this.userId,
    required this.fresh,
    required this.envelopePic,
  });

  factory NaviArticle.fromJson(Map<String, dynamic> json) {
    return NaviArticle(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      link: json['link'],
      chapterId: json['chapterId'],
      chapterName: json['chapterName'],
      superChapterName: json['superChapterName'],
      superChapterId: json['superChapterId'],
      collect: json['collect'],
      publishTime: json['publishTime'],
      niceDate: json['niceDate'],
      niceShareDate: json['niceShareDate'],
      shareUser: json['shareUser'],
      isAdminAdd: json['isAdminAdd'],
      zan: json['zan'],
      userId: json['userId'],
      fresh: json['fresh'],
      envelopePic: json['envelopePic'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'author': author,
    'link': link,
    'chapterId': chapterId,
    'chapterName': chapterName,
    'superChapterName': superChapterName,
    'superChapterId': superChapterId,
    'collect': collect,
    'publishTime': publishTime,
    'niceDate': niceDate,
    'niceShareDate': niceShareDate,
    'shareUser': shareUser,
    'isAdminAdd': isAdminAdd,
    'zan': zan,
    'userId': userId,
    'fresh': fresh,
    'envelopePic': envelopePic,
  };
}
