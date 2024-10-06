import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:the_weather/common/weather_text.dart';

class WeatherTooltip extends StatelessWidget {
  const WeatherTooltip({
    super.key,
    required this.child,
    required this.controller,
    required this.tooltipText,
    this.arrowTipDistance = 2,
    this.bottom,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.left,
    this.minimumOutsideMargin = 20,
    this.right,
    this.top,
    this.popupDirection = TooltipDirection.up,
    this.showBarrier = false,
    this.barrierColor = Colors.transparent,
    this.lightMode = false,
    this.onShow,
    this.onHide,
  });
  final Widget child;
  final SuperTooltipController controller;
  final String tooltipText;
  final double minimumOutsideMargin;
  final Duration fadeInDuration;
  final double arrowTipDistance;
  final double? right;
  final double? left;
  final double? top;
  final double? bottom;
  final TooltipDirection popupDirection;
  final bool showBarrier;
  final Color barrierColor;
  final bool lightMode;
  final void Function()? onShow;
  final void Function()? onHide;

  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      key: Key('tooltip$key'),
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      popupDirection: popupDirection,
      hasShadow: false,
      backgroundColor: lightMode ? Color(0xFFEDE5FF) : Color(0xFF1D133F),
      controller: controller,
      borderWidth: 0,
      borderColor: Color.fromARGB(0, 0, 0, 0),
      minimumOutsideMargin: minimumOutsideMargin,
      showBarrier: showBarrier,
      barrierColor: barrierColor,
      fadeInDuration: fadeInDuration,
      arrowLength: 8,
      arrowTipDistance: arrowTipDistance,
      onShow: onShow,
      onHide: onHide,
      content: WeatherText.caption(
        tooltipText,
        fontSize: 12,
        color: lightMode ? Color(0xFF121212) : Colors.white,
      ),
      child: child,
    );
  }
}
