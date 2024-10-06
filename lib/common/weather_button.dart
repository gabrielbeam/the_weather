import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_weather/common/weather_text.dart';

enum WeatherButtonSize { small, medium, large }

enum WeatherButtonType { primary, secondary }

// ignore: must_be_immutable
class WeatherButton extends StatefulWidget {
  final WeatherButtonType type;
  final String? a11yLabel;
  final WeatherButtonSize size;
  final String label;
  final FontWeight? labelFontWeight;
  final VoidCallback? onPressed;
  final bool disabled;
  final bool isLoading;
  final Widget? leading;
  final Widget? trailing;
  final double verticalMargin;
  final Color? borderColor;
  final Color? customBackgroundColor;
  final Color? color;
  final bool spread;
  final double? customFontSize;
  final double? textLineHeight;
  final double? width;
  final Duration? timerDuration;
  final Duration? timerDelay;

  const WeatherButton({
    super.key,
    this.a11yLabel,
    this.size = WeatherButtonSize.large,
    required this.label,
    this.labelFontWeight,
    this.type = WeatherButtonType.primary,
    this.onPressed,
    this.disabled = false,
    this.isLoading = false,
    this.leading,
    this.trailing,
    this.verticalMargin = 0,
    this.borderColor,
    this.color,
    this.customBackgroundColor,
    this.customFontSize,
    this.textLineHeight,
    this.width,
    this.spread = false,
    this.timerDuration,
    this.timerDelay,
  });

  const WeatherButton.withTimer({
    super.key,
    required this.timerDuration,
    this.timerDelay,
    this.a11yLabel,
    this.size = WeatherButtonSize.large,
    required this.label,
    this.labelFontWeight,
    this.type = WeatherButtonType.primary,
    this.onPressed,
    this.disabled = false,
    this.isLoading = false,
    this.leading,
    this.trailing,
    this.verticalMargin = 0,
    this.borderColor,
    this.color,
    this.customBackgroundColor,
    this.customFontSize,
    this.textLineHeight,
    this.width,
    this.spread = false,
  });

  @override
  State<WeatherButton> createState() => _WeatherButton();
}

class _WeatherButton extends State<WeatherButton> with TickerProviderStateMixin {
  bool _timerIsStarted = false;
  Timer? _timer;

  double get height {
    switch (widget.size) {
      case WeatherButtonSize.small:
        return 36.0;
      case WeatherButtonSize.medium:
      case WeatherButtonSize.large:
        return 57.0;
    }
  }

  double get padding {
    switch (widget.size) {
      case WeatherButtonSize.small:
        return 8;
      case WeatherButtonSize.medium:
      case WeatherButtonSize.large:
        return 16;
    }
  }

  double get borderRadius {
    switch (widget.size) {
      case WeatherButtonSize.small:
        return 8;
      case WeatherButtonSize.medium:
      case WeatherButtonSize.large:
      return 12;
    }
  }

  Color? get backgroundColor {
    if (widget.customBackgroundColor != null) {
      return widget.customBackgroundColor;
    }
    switch (widget.type) {
      case WeatherButtonType.primary:
        return !widget.disabled ? Color(0xFF7437FF) : Color(0xFFB899FF);
      case WeatherButtonType.secondary:
        return Color.fromARGB(0, 0, 0, 0);
      }
  }

  Color get fontColor {
    if (widget.color != null) {
      return widget.color!;
    }
    switch (widget.type) {
      case WeatherButtonType.primary:
        return Color(0xFFF6F2FF);
      case WeatherButtonType.secondary:
        return !widget.disabled ? Color(0xFF7437FF) : Color(0xFFB899FF);
    }
  }

  double get fontSize {
    if (widget.customFontSize != null) {
      return widget.customFontSize!;
    }

    switch (widget.size) {
      case WeatherButtonSize.small:
        return 14;
      case WeatherButtonSize.medium:
      case WeatherButtonSize.large:
        return 18;
    }
  }

  TextStyle getTextStyle(BuildContext context) {
    switch (widget.size) {
      case WeatherButtonSize.small:
        return const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, height: 1.4);
      case WeatherButtonSize.medium:
      case WeatherButtonSize.large:
        return const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, height: 1.4);
    }
  }

  _onPressed(String? label, [BuildContext? context, String? buttonType]) {
    String? route = "unknown";
    if (context != null) {
      route = ModalRoute.of(context)?.settings.name;
    }
    widget.onPressed?.call();
  }

  @override
  void initState() {
    super.initState();

    if (mounted && widget.timerDuration != null) {
      final delay = widget.timerDelay ?? Duration.zero;
      final duration = widget.timerDuration ?? Duration.zero;
      Future.delayed(delay, () {
        if (mounted) {
          setState(() {
            _timerIsStarted = true;
          });
        }

        _timer = Timer(
          Duration(milliseconds: duration.inMilliseconds),
          () => _onPressed(
            widget.a11yLabel,
            null,
            "beam_button.withTimer",
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.a11yLabel,
      onTap: () => _onPressed(widget.a11yLabel, context),
      child: GestureDetector(
        onTap: () {
          if (!widget.disabled && widget.onPressed != null && !widget.isLoading) {
            if (widget.timerDuration != null) {
              _timer?.cancel();
            }
            _onPressed(widget.a11yLabel, context);
          }
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            height: height,
            width: widget.width,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(vertical: widget.verticalMargin),
            alignment: Alignment.center,
            decoration: widget.type == WeatherButtonType.secondary
                ? BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          : !widget.disabled
                              ? Color(0xFF7437FF)
                              : Color(0xFFB899FF),
                      width: 1,
                    ))
                : BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
            child: Stack(
              children: [
                if (widget.timerDuration != null) ...[
                  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    return AnimatedContainer(
                      duration: widget.timerDuration ?? Duration.zero,
                      curve: Curves.ease,
                      height: constraints.maxHeight,
                      width: _timerIsStarted ? constraints.maxWidth : 0,
                      color: _timerIsStarted ? Color(0xFF3A1C80) : Color(0xFF7437FF),
                    );
                  }),
                ],
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(padding),
                  child: !widget.isLoading
                      ? Row(
                          mainAxisSize: widget.spread ? MainAxisSize.max : MainAxisSize.min,
                          mainAxisAlignment: widget.spread ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                          children: [
                            if (widget.leading != null) widget.leading!,
                            if (widget.leading != null) const SizedBox(width: 8),
                            WeatherText.body(
                              widget.label,
                              fontWeight: widget.labelFontWeight ?? FontWeight.w700,
                              color: fontColor,
                              fontSize: fontSize,
                              lineHeight: widget.textLineHeight,
                              isTitle: true,
                            ),
                            if (widget.trailing != null) const SizedBox(width: 8),
                            if (widget.trailing != null) widget.trailing!,
                          ],
                        )
                      : AspectRatio(
                          aspectRatio: 1,
                          child: CircularProgressIndicator(
                            key: Key("loading_indicator"),
                            strokeWidth: 2,
                            color: fontColor,
                          ),
                        ),
                )
              ],
            )),
      ),
    );
  }
}