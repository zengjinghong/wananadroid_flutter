/// {
//     "data": [
//         {
//             "desc": "我们支持订阅啦~",
//             "id": 30,
//             "imagePath": "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
//             "isVisible": 1,
//             "order": 2,
//             "title": "我们支持订阅啦~",
//             "type": 0,
//             "url": "https://www.wanandroid.com/blog/show/3352"
//         },
//         {
//             "desc": "",
//             "id": 6,
//             "imagePath": "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
//             "isVisible": 1,
//             "order": 1,
//             "title": "我们新增了一个常用导航Tab~",
//             "type": 1,
//             "url": "https://www.wanandroid.com/navi"
//         },
//         {
//             "desc": "一起来做个App吧",
//             "id": 10,
//             "imagePath": "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
//             "isVisible": 1,
//             "order": 1,
//             "title": "一起来做个App吧",
//             "type": 1,
//             "url": "https://www.wanandroid.com/blog/show/2"
//         }
//     ],
//     "errorCode": 0,
//     "errorMsg": ""
// }

class BannerResponse {
  final int errorCode;
  final String errorMsg;
  final List<BannerItem> data;

  BannerResponse({
    required this.errorCode,
    required this.errorMsg,
    required this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      errorCode: json['errorCode'] ?? 0,
      errorMsg: json['errorMsg'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => BannerItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errorCode': errorCode,
      'errorMsg': errorMsg,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

/// 单个 banner 项 （对应 data 中每一项）
class BannerItem {
  final String desc;
  final int id;
  final String imagePath;
  final int isVisible;
  final int order;
  final String title;
  final int type;
  final String url;

  BannerItem({
    required this.desc,
    required this.id,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      desc: json['desc'] ?? '',
      id: json['id'],
      imagePath: json['imagePath'] ?? '',
      isVisible: json['isVisible'] ?? 1,
      order: json['order'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'] ?? 0,
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'desc': desc,
      'id': id,
      'imagePath': imagePath,
      'isVisible': isVisible,
      'order': order,
      'title': title,
      'type': type,
      'url': url,
    };
  }
}
