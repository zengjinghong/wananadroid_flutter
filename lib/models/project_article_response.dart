class ProjectArticleResponse {
  final ProjectArticleData data;
  final int errorCode;
  final String errorMsg;

  ProjectArticleResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory ProjectArticleResponse.fromJson(Map<String, dynamic> json) {
    return ProjectArticleResponse(
      data: ProjectArticleData.fromJson(json['data']),
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
        'errorCode': errorCode,
        'errorMsg': errorMsg,
      };
}

class ProjectArticleData {
  final int curPage;
  final List<ProjectArticle> datas;
  final int offset;
  final bool over;
  final int pageCount;
  final int size;
  final int total;

  ProjectArticleData({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory ProjectArticleData.fromJson(Map<String, dynamic> json) {
    return ProjectArticleData(
      curPage: json['curPage'],
      datas: (json['datas'] as List)
          .map((e) => ProjectArticle.fromJson(e))
          .toList(),
      offset: json['offset'],
      over: json['over'],
      pageCount: json['pageCount'],
      size: json['size'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
        'curPage': curPage,
        'datas': datas.map((e) => e.toJson()).toList(),
        'offset': offset,
        'over': over,
        'pageCount': pageCount,
        'size': size,
        'total': total,
      };
}

class ProjectArticle {
  final bool adminAdd;
  final String apkLink;
  final int audit;
  final String author;
  final bool canEdit;
  final int chapterId;
  final String chapterName;
  bool collect;
  final int courseId;
  final String desc;
  final String descMd;
  final String envelopePic;
  final bool fresh;
  final String host;
  final int id;
  final bool isAdminAdd;
  final String link;
  final String niceDate;
  final String niceShareDate;
  final String origin;
  final String prefix;
  final String projectLink;
  final int publishTime;
  final int realSuperChapterId;
  final int selfVisible;
  final int? shareDate;
  final String shareUser;
  final int superChapterId;
  final String superChapterName;
  final List<ProjectTag> tags;
  final String title;
  final int type;
  final int userId;
  final int visible;
  final int zan;

  ProjectArticle({
    required this.adminAdd,
    required this.apkLink,
    required this.audit,
    required this.author,
    required this.canEdit,
    required this.chapterId,
    required this.chapterName,
    required this.collect,
    required this.courseId,
    required this.desc,
    required this.descMd,
    required this.envelopePic,
    required this.fresh,
    required this.host,
    required this.id,
    required this.isAdminAdd,
    required this.link,
    required this.niceDate,
    required this.niceShareDate,
    required this.origin,
    required this.prefix,
    required this.projectLink,
    required this.publishTime,
    required this.realSuperChapterId,
    required this.selfVisible,
    required this.shareDate,
    required this.shareUser,
    required this.superChapterId,
    required this.superChapterName,
    required this.tags,
    required this.title,
    required this.type,
    required this.userId,
    required this.visible,
    required this.zan,
  });

  factory ProjectArticle.fromJson(Map<String, dynamic> json) {
    return ProjectArticle(
      adminAdd: json['adminAdd'],
      apkLink: json['apkLink'],
      audit: json['audit'],
      author: json['author'],
      canEdit: json['canEdit'],
      chapterId: json['chapterId'],
      chapterName: json['chapterName'],
      collect: json['collect'],
      courseId: json['courseId'],
      desc: json['desc'],
      descMd: json['descMd'],
      envelopePic: json['envelopePic'],
      fresh: json['fresh'],
      host: json['host'],
      id: json['id'],
      isAdminAdd: json['isAdminAdd'],
      link: json['link'],
      niceDate: json['niceDate'],
      niceShareDate: json['niceShareDate'],
      origin: json['origin'],
      prefix: json['prefix'],
      projectLink: json['projectLink'],
      publishTime: json['publishTime'],
      realSuperChapterId: json['realSuperChapterId'],
      selfVisible: json['selfVisible'],
      shareDate: json['shareDate'],
      shareUser: json['shareUser'],
      superChapterId: json['superChapterId'],
      superChapterName: json['superChapterName'],
      tags: (json['tags'] as List).map((e) => ProjectTag.fromJson(e)).toList(),
      title: json['title'],
      type: json['type'],
      userId: json['userId'],
      visible: json['visible'],
      zan: json['zan'],
    );
  }

  Map<String, dynamic> toJson() => {
        'adminAdd': adminAdd,
        'apkLink': apkLink,
        'audit': audit,
        'author': author,
        'canEdit': canEdit,
        'chapterId': chapterId,
        'chapterName': chapterName,
        'collect': collect,
        'courseId': courseId,
        'desc': desc,
        'descMd': descMd,
        'envelopePic': envelopePic,
        'fresh': fresh,
        'host': host,
        'id': id,
        'isAdminAdd': isAdminAdd,
        'link': link,
        'niceDate': niceDate,
        'niceShareDate': niceShareDate,
        'origin': origin,
        'prefix': prefix,
        'projectLink': projectLink,
        'publishTime': publishTime,
        'realSuperChapterId': realSuperChapterId,
        'selfVisible': selfVisible,
        'shareDate': shareDate,
        'shareUser': shareUser,
        'superChapterId': superChapterId,
        'superChapterName': superChapterName,
        'tags': tags.map((e) => e.toJson()).toList(),
        'title': title,
        'type': type,
        'userId': userId,
        'visible': visible,
        'zan': zan,
      };
}

class ProjectTag {
  final String name;
  final String url;

  ProjectTag({
    required this.name,
    required this.url,
  });

  factory ProjectTag.fromJson(Map<String, dynamic> json) {
    return ProjectTag(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}
