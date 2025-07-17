import 'package:flutter/material.dart';

import '../models/project_article_response.dart';

class ProjectArticleItemLayout extends StatefulWidget {
  final ProjectArticle projectArticle; // 文章数据模型
  final void Function() onCollectTap; // 收藏按钮点击回调

  const ProjectArticleItemLayout({
    Key? key,
    required this.projectArticle,
    required this.onCollectTap,
  }) : super(key: key);

  @override
  _ProjectArticleItemState createState() => _ProjectArticleItemState();
}

class _ProjectArticleItemState extends State<ProjectArticleItemLayout> {
  @override
  Widget build(BuildContext context) {
    final article = widget.projectArticle;

    String publishTime = DateTime.fromMillisecondsSinceEpoch(article.publishTime)
        .toString()
        .substring(0, 16); // 保留 "yyyy-MM-dd HH:mm"

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: GestureDetector(
        onTap: widget.onCollectTap,
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // 左侧封面图
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    article.envelopePic,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 96,
                      height: 96,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // 右侧内容区
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // 简介内容
                      Text(
                        article.desc,
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // 作者和时间 + 收藏按钮
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${article.author} · $publishTime",
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      )
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
