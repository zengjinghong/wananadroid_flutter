/// 登录相关数据类
/// {
//     "data": {
//         "admin": false,
//         "chapterTops": [
//
//         ],
//         "coinCount": 361,
//         "collectIds": [
//             28882,
//             16755,
//             28889,
//             12470,
//             18281,
//             27962,
//             27961,
//             29954,
//             29941
//         ],
//         "email": "",
//         "icon": "",
//         "id": 163636,
//         "nickname": "AdminZJH",
//         "password": "",
//         "publicName": "AdminZJH",
//         "token": "",
//         "type": 0,
//         "username": "AdminZJH"
//     },
//     "errorCode": 0,
//     "errorMsg": ""
// }
class LoginRegisterResponse {
  final int errorCode;
  final String errorMsg;
  final UserInfo? data;

  LoginRegisterResponse({
    required this.errorCode,
    required this.errorMsg,
    required this.data,
  });

  /// 将 JSON 转换为对象
  factory LoginRegisterResponse.fromJson(Map<String, dynamic> json) {
    return LoginRegisterResponse(
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'] ?? '',
      data: json['data'] != null ? UserInfo.fromJson(json['data']) : null,
    );
  }

  /// 将对象转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'errorCode': errorCode,
      'errorMsg': errorMsg,
      'data': data?.toJson(), // 注意 data 可能为空
    };
  }

}

class UserInfo {
  final bool admin;
  final List<dynamic> chapterTops;
  final int coinCount;
  final List<int> collectIds;
  final String email;
  final String icon;
  final int id;
  final String nickname;
  final String password;
  final String publicName;
  final String token;
  final int type;
  final String username;

  UserInfo({
    required this.admin,
    required this.chapterTops,
    required this.coinCount,
    required this.collectIds,
    required this.email,
    required this.icon,
    required this.id,
    required this.nickname,
    required this.password,
    required this.publicName,
    required this.token,
    required this.type,
    required this.username,
  });

  /// 将 JSON 转换为对象
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      admin: json['admin'],
      chapterTops: json['chapterTops'] ?? [],
      coinCount: json['coinCount'],
      collectIds: List<int>.from(json['collectIds']),
      email: json['email'] ?? '',
      icon: json['icon'] ?? '',
      id: json['id'],
      nickname: json['nickname'] ?? '',
      password: json['password'] ?? '',
      publicName: json['publicName'] ?? '',
      token: json['token'] ?? '',
      type: json['type'],
      username: json['username'] ?? '',
    );
  }

  /// 将对象转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'admin': admin,
      'chapterTops': chapterTops,
      'coinCount': coinCount,
      'collectIds': collectIds,
      'email': email,
      'icon': icon,
      'id': id,
      'nickname': nickname,
      'password': password,
      'publicName': publicName,
      'token': token,
      'type': type,
      'username': username,
    };
  }
}
