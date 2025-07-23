import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wananadroid_flutter/models/collect_list_response.dart';

class CollectItemLayout extends StatefulWidget {
  // 构造函数，接收文章数据、收藏点击回调及是否显示收藏按钮
  const CollectItemLayout({
    Key? key,
    required this.onCollectTap,
    required this.collectDetail,
  }) : super(key: key);

  final CollectDetail collectDetail; // 文章数据模型

  final void Function() onCollectTap; // 收藏按钮点击回调

  @override
  State<StatefulWidget> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<CollectItemLayout> {
  @override
  Widget build(BuildContext context) {
    // 格式化发布时间字符串，去除末尾多余字符
    String publishTime =
        DateTime.fromMillisecondsSinceEpoch(widget.collectDetail.publishTime)
            .toString();
    publishTime = publishTime.substring(0, publishTime.length - 4);

    // 拼接文章分类字符串，格式为 “父分类·子分类”
    StringBuffer sb = StringBuffer(widget.collectDetail.chapterName ?? "");
    if (sb.isNotEmpty && widget.collectDetail.chapterName.isNotEmpty) {
      sb.write("·");
    }
    sb.write(widget.collectDetail.chapterName ?? "");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: widget.onCollectTap,
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          elevation: 8, // 卡片阴影
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    // 作者名称，若作者为空显示分享人
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text(
                          '作者: ${widget.collectDetail.author.isNotEmpty == true ? widget.collectDetail.author : "暂无"}'),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        alignment: Alignment.centerRight,
                        // 发布时间显示
                        child: Text(publishTime),
                      ),
                    )
                  ],
                ),
                // 文章标题区域，支持HTML样式并限制最大两行，溢出省略
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Html(
                            data: widget.collectDetail.title,
                            style: {
                              "html": Style(
                                  margin: Margins.zero,
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                  fontSize: FontSize(14),
                                  padding: HtmlPaddings.zero,
                                  alignment: Alignment.topLeft),
                              "body": Style(
                                  margin: Margins.zero,
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                  fontSize: FontSize(14),
                                  padding: HtmlPaddings.zero,
                                  alignment: Alignment.topLeft)
                            },
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
