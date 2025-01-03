import 'package:flutter/material.dart';

class AnimatedChild extends AnimatedWidget {
  final int? index;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final Size buttonSize;
  final Widget? child;
  final List<BoxShadow>? labelShadow;
  final Key? btnKey;

  final String? label;
  final TextStyle? labelStyle;
  final Color? labelBackgroundColor;
  final Widget? labelWidget;

  final bool visible;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? toggleChildren;
  final ShapeBorder? shape;
  final String? heroTag;
  final bool useColumn;
  final bool switchLabelPosition;
  final EdgeInsets? margin;

  final EdgeInsets childMargin;
  final EdgeInsets childPadding;

  const AnimatedChild({
    Key? key,
    this.btnKey,
    required Animation<double> animation,
    this.index,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.buttonSize = const Size(56.0, 56.0),
    this.child,
    this.label,
    this.labelStyle,
    this.labelShadow,
    this.labelBackgroundColor,
    this.labelWidget,
    this.visible = true,
    this.onTap,
    required this.switchLabelPosition,
    required this.useColumn,
    required this.margin,
    this.onLongPress,
    this.toggleChildren,
    this.shape,
    this.heroTag,
    required this.childMargin,
    required this.childPadding,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    bool dark = Theme.of(context).brightness == Brightness.dark;

    void performAction([bool isLong = false]) {
      if (onTap != null && !isLong) {
        onTap!();
      } else if (onLongPress != null && isLong) {
        onLongPress!();
      }
      toggleChildren!();
    }

    Widget buildContent() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0x17000000),
              offset: Offset(0, 6),
              blurRadius: 6,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 13),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          onTap: performAction,
          onLongPress: onLongPress == null ? null : () => performAction(true),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (child != null)
                  SizedBox(
                    height: buttonSize.height,
                    width: buttonSize.width,
                    child: child,
                  ),
                if (label != null || labelWidget != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: labelWidget ?? Text(
                      label!,
                      style: labelStyle ?? TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return visible
        ? Container(
            margin: margin,
            child: ScaleTransition(
              scale: animation,
              child: buildContent(),
            ),
          )
        : Container();
  }
}
