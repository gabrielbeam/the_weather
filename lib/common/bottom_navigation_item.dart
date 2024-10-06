
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:the_weather/common/tooltip.dart';
import 'package:the_weather/common/weather_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BottomNavigationItem extends ConsumerStatefulWidget {
  const BottomNavigationItem({
    super.key,
    required this.title,
    required this.titleStyle,
    this.titleImage,
    this.onTap,
    this.showBadge,
    this.showTooltip = false,
    this.tooltipText,
  });

  final String title;
  final SvgPicture? titleImage;
  final TextStyle titleStyle;
  final VoidCallback? onTap;
  final bool? showBadge;
  final bool? showTooltip;
  final String? tooltipText;

  @override
  ConsumerState createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends ConsumerState<BottomNavigationItem> {
  final SuperTooltipController _tooltipController = SuperTooltipController();

  @override
  void didUpdateWidget(old) {
    super.didUpdateWidget(old);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.showTooltip == null) return;
      if (widget.showTooltip!) {
        _tooltipController.showTooltip();
      } else {
        _tooltipController.hideTooltip();
      }
    });
  }

  _onPressed(String? label, BuildContext context) {
    _tooltipController.hideTooltip();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("bottomNavigatorItem"),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.0 && widget.showTooltip!) {
          _tooltipController.showTooltip();
        } else {
          _tooltipController.hideTooltip();
        }
      },
      child: InkWell(
          onTap: () => _onPressed(widget.key.toString(), context),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                // direction: Axis.vertical,
                // spacing: 1, // <-- Spacing between children
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.titleImage != null) widget.titleImage!,
                  const SizedBox(
                    height: 6,
                  ),
                  WeatherText.caption(
                    widget.title,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: widget.titleStyle.color!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              if (widget.showBadge ?? false) ...[
                Positioned(
                  // draw a red badge
                  top: 15.0,
                  right: 25.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 0.5, color: Colors.white),
                    ),
                    child: Icon(Icons.brightness_1_rounded, size: 8.0, color: Color(0xFFFF4A59)),
                  ),
                )
              ],
              // We can't wrap the tooltip on top of menu item because tooltip
              // will cancel onTap from InkWell/GestureDetector
              // so we separate it with a transparent SizedBox
              if (widget.showTooltip ?? false) ...[
                Positioned(
                  top: -10,
                  child: WeatherTooltip(
                    key: Key("bottomNavigatorItem"),
                    controller: _tooltipController,
                    right: 10,
                    tooltipText: widget.tooltipText ?? '',
                    child: const SizedBox(width: 10, height: 10),
                  ),
                )
              ]
            ],
          )),
    );
  }
}
