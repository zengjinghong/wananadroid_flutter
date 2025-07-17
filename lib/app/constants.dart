/// 常量配置，如接口地址、主题色等

class ApiConstants {
  static const String baseUrl = "https://www.wanandroid.com/";

  /// 首页文章
  static const String homePageArticle = "article/list/";

  /// 置顶文章
  static const String topArticle = "article/top/json";

  /// 获取banner
  static const String banner = "banner/json";

  /// 登录
  static const String login = "user/login";

  /// 注册
  static const String register = "user/register";

  /// 体系
  static const String tree = "tree/json";

  /// 导航
  static const String navi = "navi/json";

  /// 退出登录
  static const String logout = "user/logout/json";

  /// 项目分类
  static const String projectCategory = "project/tree/json";

  /// 项目列表
  static const String projectList = "project/list/";

  /// 搜索
  static const String searchForKeyword = "article/query/";

  /// 广场页列表
  static const String plazaArticleList = "user_article/list/";

  /// 点击收藏
  static const String collectArticle = "lg/collect/";

  /// 取消收藏
  static const String uncollectArticel = "lg/uncollect_originId/";

  /// 获取搜索热词
  static const String hotKeywords = "hotkey/json";

  /// 获取收藏文章列表
  static const String collectList = "lg/collect/list/";

  /// 收藏网站列表
  static const String collectWebaddressList = "lg/collect/usertools/json";

  /// 我的分享
  static const String sharedList = "user/lg/private_articles/";

  /// 分享文章 post
  static const String shareArticle = "lg/user_article/add/json";

  /// todoList
  static const String todoList = "lg/todo/v2/list/";
}

class RoutesConstants {
  /// 登录注册界面
  static const String login = "/login_register";

  /// 首页
  static const String home = "/home";

  /// 体系文章列表
  static const String treeChild = "/tree_child";
}

/// 尺寸常量
class DimenConstant {
  static const double dimen_5 = 5;
  static const double dimen_10 = 10;
  static const double dimen_15 = 15;
  static const double dimen_22 = 22;
  static const double dimen_44 = 44;
}

/// 图片地址常量
class ImageConstant {
  static const String buttonProgress =
      "assets/images/vp_ic_button_progress.webp";
  static const String buttonSelectProgress =
      "assets/images/vp_ic_button_select_progress.webp";
  static const String buttonWarnProgress =
      "assets/images/vp_ic_button_warn_progress.webp";
  static const String buttonLeftDownLoad =
      "assets/images/vp_ic_button_down_load.webp";
  static const String buttonLeftSendInvite =
      "assets/images/vp_ic_button_send_invite.webp";
  static const String imageDefault = "assets/images/vp_ic_image_default.png";
  static const String ratingNormal = "assets/images/vp_ic_rating_normal.webp";
  static const String ratingSelected =
      "assets/images/vp_ic_rating_selected.webp";
}
