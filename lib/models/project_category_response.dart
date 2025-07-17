class ProjectCategoryResponse {
  final List<ProjectCategory> data;
  final int errorCode;
  final String errorMsg;

  ProjectCategoryResponse({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory ProjectCategoryResponse.fromJson(Map<String, dynamic> json) {
    return ProjectCategoryResponse(
      data: (json['data'] as List)
          .map((e) => ProjectCategory.fromJson(e))
          .toList(),
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
    'errorCode': errorCode,
    'errorMsg': errorMsg,
  };
}

class ProjectCategory {
  final List<dynamic> articleList; // 为空数组，暂时用 dynamic 占位
  final String author;
  final List<dynamic> children; // 同上
  final int courseId;
  final String cover;
  final String desc;
  final int id;
  final String lisense;
  final String lisenseLink;
  final String name;
  final int order;
  final int parentChapterId;
  final int type;
  final bool userControlSetTop;
  final int visible;

  ProjectCategory({
    required this.articleList,
    required this.author,
    required this.children,
    required this.courseId,
    required this.cover,
    required this.desc,
    required this.id,
    required this.lisense,
    required this.lisenseLink,
    required this.name,
    required this.order,
    required this.parentChapterId,
    required this.type,
    required this.userControlSetTop,
    required this.visible,
  });

  factory ProjectCategory.fromJson(Map<String, dynamic> json) {
    return ProjectCategory(
      articleList: json['articleList'] ?? [],
      author: json['author'] ?? '',
      children: json['children'] ?? [],
      courseId: json['courseId'],
      cover: json['cover'] ?? '',
      desc: json['desc'] ?? '',
      id: json['id'],
      lisense: json['lisense'] ?? '',
      lisenseLink: json['lisenseLink'] ?? '',
      name: json['name'] ?? '',
      order: json['order'],
      parentChapterId: json['parentChapterId'],
      type: json['type'],
      userControlSetTop: json['userControlSetTop'],
      visible: json['visible'],
    );
  }

  Map<String, dynamic> toJson() => {
    'articleList': articleList,
    'author': author,
    'children': children,
    'courseId': courseId,
    'cover': cover,
    'desc': desc,
    'id': id,
    'lisense': lisense,
    'lisenseLink': lisenseLink,
    'name': name,
    'order': order,
    'parentChapterId': parentChapterId,
    'type': type,
    'userControlSetTop': userControlSetTop,
    'visible': visible,
  };
}

