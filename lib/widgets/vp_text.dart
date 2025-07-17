import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../app/constants.dart';
import '../base/base_widget.dart';
import '../bean/text_rich_bean.dart';

/// 一个支持可配置图标（上下左右）及富文本的通用文本组件
class VpText extends BaseWidget {
  // 普通文本内容
  final String text;

  // 普通文本样式
  final TextStyle? style;

  // 左侧图标资源路径（可为网络或本地）
  final String? leftIcon;

  // 左侧图标宽度
  final double? leftIconWidth;

  // 左侧图标高度
  final double? leftIconHeight;

  // 左图标与右侧文字之间的间距
  final double? iconMarginRight;

  // 右侧图标资源路径
  final String? rightIcon;

  // 右侧图标宽度
  final double? rightIconWidth;

  // 右侧图标高度
  final double? rightIconHeight;

  // 右图标与左侧文字之间的间距
  final double? iconMarginLeft;

  // 顶部图标资源路径
  final String? topIcon;

  // 顶部图标宽度
  final double? topIconWidth;

  // 顶部图标高度
  final double? topIconHeight;

  // 顶图标与下方文字之间的间距
  final double? iconMarginBottom;

  // 底部图标资源路径
  final String? bottomIcon;

  // 底部图标宽度
  final double? bottomIconWidth;

  // 底部图标高度
  final double? bottomIconHeight;

  // 底图标与上方文字之间的间距
  final double? iconMarginTop;

  // 主轴对齐方式（用于 Row/Column）
  final MainAxisAlignment? mainAxisAlignment;

  // 文本溢出时的处理方式
  final TextOverflow? textOverflow;

  // 文本对齐方式
  final TextAlign? textAlign;

  // 文本最大行数
  final int? maxLines;

  // 富文本内容列表
  final List<TextRichBean>? richList;

  // 富文本点击回调
  final Function(int, TextRichBean)? onRichClick;

  const VpText(
      this.text, {
        super.key,
        this.style,
        this.leftIcon,
        this.leftIconWidth = DimenConstant.dimen_22,
        this.leftIconHeight = DimenConstant.dimen_22,
        this.iconMarginRight = 0,
        this.rightIcon,
        this.rightIconWidth = DimenConstant.dimen_22,
        this.rightIconHeight = DimenConstant.dimen_22,
        this.iconMarginLeft = 0,
        this.topIcon,
        this.topIconWidth = DimenConstant.dimen_22,
        this.topIconHeight = DimenConstant.dimen_22,
        this.iconMarginBottom = 0,
        this.bottomIcon,
        this.bottomIconWidth = DimenConstant.dimen_22,
        this.bottomIconHeight = DimenConstant.dimen_22,
        this.iconMarginTop = 0,
        this.mainAxisAlignment = MainAxisAlignment.center,
        this.textOverflow,
        this.textAlign,
        this.maxLines,
        this.richList,
        this.onRichClick,
        // BaseWidget 的参数（布局、样式、点击等）
        super.width,
        super.height,
        super.margin,
        super.marginLeft,
        super.marginTop,
        super.marginRight,
        super.marginBottom,
        super.padding,
        super.paddingLeft,
        super.paddingTop,
        super.paddingRight,
        super.paddingBottom,
        super.backgroundColor,
        super.strokeWidth,
        super.strokeColor,
        super.solidColor,
        super.radius,
        super.isCircle,
        super.leftTopRadius,
        super.rightTopRadius,
        super.leftBottomRadius,
        super.rightBottomRadius,
        super.childWidget,
        super.alignment,
        super.onClick,
        super.onDoubleClick,
        super.onLongPress,
      });

  /// 获取图标对应的组件（支持网络与本地资源）
  Widget getImageWidget(String icon, double width, double height) {
    if (icon.contains("http")) {
      return Image.network(icon, width: width, height: height);
    } else {
      return Image.asset(icon, width: width, height: height);
    }
  }

  /// 构建组件主体
  @override
  Widget getWidget(BuildContext context) {
    List<Widget> widgets = [];

    // 如果有左图标，添加到组件列表
    if (leftIcon != null) {
      widgets.add(getImageWidget(leftIcon!, leftIconWidth!, leftIconHeight!));
    }

    // 如果左右图标存在，则将文字放中间并添加边距
    if (leftIcon != null || rightIcon != null) {
      widgets.add(Container(
        margin: EdgeInsets.only(left: iconMarginRight!, right: iconMarginLeft!),
        child: getTextWidget(),
      ));
    }

    // 如果有右图标，添加到组件列表
    if (rightIcon != null) {
      widgets.add(getImageWidget(rightIcon!, rightIconWidth!, rightIconHeight!));
    }

    // 如果左右任一图标存在，使用 Row 布局返回
    if (widgets.isNotEmpty) {
      return Row(
        mainAxisAlignment: mainAxisAlignment!,
        children: widgets,
      );
    }

    // 重置 widgets 列表用于垂直方向图标布局
    if (topIcon != null) {
      widgets.add(getImageWidget(topIcon!, topIconWidth!, topIconHeight!));
    }

    // 如果上下图标存在，将文字放中间
    if (topIcon != null || bottomIcon != null) {
      widgets.add(Container(
        margin: EdgeInsets.only(top: iconMarginBottom!, bottom: iconMarginTop!),
        child: getTextWidget(),
      ));
    }

    // 添加底部图标
    if (bottomIcon != null) {
      widgets.add(getImageWidget(bottomIcon!, bottomIconWidth!, bottomIconHeight!));
    }

    // 如果上下任一图标存在，使用 Column 布局返回
    if (widgets.isNotEmpty) {
      return Column(
        mainAxisAlignment: mainAxisAlignment!,
        children: widgets,
      );
    }

    // 如果设置了富文本，构建并返回富文本组件
    if (richList != null && richList!.isNotEmpty) {
      List<TextSpan> list = [];
      for (var a = 0; a < richList!.length; a++) {
        var richBean = richList![a];
        var textSpan = TextSpan(
          text: richBean.text,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (onRichClick != null) {
                onRichClick!(a, richBean);
              }
            },
          style: TextStyle(
            fontSize: richBean.textSize,
            color: richBean.textColor,
          ),
        );
        list.add(textSpan);
      }
      return Text.rich(TextSpan(children: list));
    }

    // 默认仅返回普通文本组件
    return getTextWidget();
  }

  /// 构建普通文本组件
  Widget getTextWidget() {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style,
    );
  }
}
