class CollectResponse {
  final Collect? data;
  final int errorCode;
  final String errorMsg;

  CollectResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory CollectResponse.fromJson(Map<String, dynamic> json) {
    return CollectResponse(
      data: json['data'] != null ? Collect.fromJson(json['data']) : null,
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}
class Collect {
  final int curPage;
  final List<CollectDetail> datas;
  final int offset;
  final bool over;
  final int pageCount;
  final int size;
  final int total;

  Collect({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory Collect.fromJson(Map<String, dynamic> json) {
    return Collect(
      curPage: json['curPage'],
      datas: (json['datas'] as List)
          .map((e) => CollectDetail.fromJson(e))
          .toList(),
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

class CollectDetail {
  final String author;
  final int chapterId;
  final String chapterName;
  final int courseId;
  final String desc;
  final String envelopePic;
  final int id;
  final String link;
  final String niceDate;
  final String origin;
  final int originId;
  final int publishTime;
  final String title;
  final int userId;
  final int visible;
  final int zan;

  CollectDetail({
    required this.author,
    required this.chapterId,
    required this.chapterName,
    required this.courseId,
    required this.desc,
    required this.envelopePic,
    required this.id,
    required this.link,
    required this.niceDate,
    required this.origin,
    required this.originId,
    required this.publishTime,
    required this.title,
    required this.userId,
    required this.visible,
    required this.zan,
  });

  factory CollectDetail.fromJson(Map<String, dynamic> json) {
    return CollectDetail(
      author: json['author'] ?? '',
      chapterId: json['chapterId'],
      chapterName: json['chapterName'] ?? '',
      courseId: json['courseId'],
      desc: json['desc'] ?? '',
      envelopePic: json['envelopePic'] ?? '',
      id: json['id'],
      link: json['link'] ?? '',
      niceDate: json['niceDate'] ?? '',
      origin: json['origin'] ?? '',
      originId: json['originId'],
      publishTime: json['publishTime'],
      title: json['title'] ?? '',
      userId: json['userId'],
      visible: json['visible'],
      zan: json['zan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'chapterId': chapterId,
      'chapterName': chapterName,
      'courseId': courseId,
      'desc': desc,
      'envelopePic': envelopePic,
      'id': id,
      'link': link,
      'niceDate': niceDate,
      'origin': origin,
      'originId': originId,
      'publishTime': publishTime,
      'title': title,
      'userId': userId,
      'visible': visible,
      'zan': zan,
    };
  }
}
