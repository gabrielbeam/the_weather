import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_weather/api/meteomatics.dart';
import 'package:the_weather/common/custom_image.dart';
import 'package:the_weather/common/geolocator.dart';
import 'package:the_weather/common/weather_button.dart';
import 'package:the_weather/common/weather_text.dart';

class CommonModal extends StatefulWidget {
  final String title;
  final TextAlign? titleTextAlign;
  final String content;
  final TextAlign? contentTextAlign;
  final double? contentFontSize;
  final Color? contentColor;
  final bool enableReportIssueButton;
  final Widget? image;
  final bool crossIconOverImage;
  final String? fineAmount;
  final String? abandonmentFineAmount;
  final ModalButton? primaryButton;
  final ModalButton? secondaryButton;
  final bool isDismissible;
  final Widget Function()? headerRenderFunc;
  final Widget Function()? contentRenderFunc;
  final EdgeInsets paddingAroundContentRenderFunc;
  final EdgeInsets? padding;
  final double? primarySecondaryButtonMargin;
  final VoidCallback? onClosed;
  final bool showPrimaryButtonLoader;
  final ModalButtonDirection? buttonDirection;
  final double? imageWidth;
  final bool decorationNeeded;

  const CommonModal(
    this.title,
    this.content, {
    this.titleTextAlign,
    this.contentTextAlign,
    this.contentFontSize,
    this.contentColor,
    this.enableReportIssueButton = false,
    this.primaryButton,
    this.secondaryButton,
    this.crossIconOverImage = false,
    this.fineAmount,
    this.abandonmentFineAmount,
    this.image,
    this.isDismissible = true,
    this.headerRenderFunc,
    this.contentRenderFunc,
    this.padding,
    this.paddingAroundContentRenderFunc = const EdgeInsets.symmetric(vertical: 16),
    this.primarySecondaryButtonMargin,
    this.onClosed,
    this.showPrimaryButtonLoader = true,
    this.buttonDirection = ModalButtonDirection.vertical,
    this.imageWidth,
    this.decorationNeeded = true,
  });

  @override
  State<CommonModal> createState() => _CommonModalState();
}

class _CommonModalState extends State<CommonModal> {
  bool primaryButtonIsLoading = false;
  double lastDayPrecipitation = 0.0;
  @override
  void initState() {
    super.initState();
    _updatePrecipitation();
  }

    _updatePrecipitation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double lastDayPrecipitation =
        prefs.getDouble('lastDayPrecipitation') ?? 0.0;
    if (lastDayPrecipitation == 0.0) {
      determinePosition().then((value) async {
        DateTime now = DateTime.now().toUtc();
        String timestamp = now.toIso8601String();
        await getPrecipitationData(
                timestamp: timestamp, lat: value.latitude, lon: value.longitude)
            .then((value) {
          if (value.data.isNotEmpty) {
            for (var e in value.data[0].coordinates[0].dates) {
              lastDayPrecipitation += e.value;
            }
            prefs.setDouble("lastDayPrecipitation", lastDayPrecipitation);
          }
        });
      });
    }
    setState(() {
      this.lastDayPrecipitation = lastDayPrecipitation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.image != null;
    
    final handlerClosedClick = widget.onClosed ?? () => Navigator.of(context).pop(true);
    final double modalBottomSpace = widget.buttonDirection == ModalButtonDirection.vertical
        ? (widget.primaryButton != null ? 55 : 0) + (widget.secondaryButton != null ? 55 : 0)
        : (widget.primaryButton != null || widget.secondaryButton != null ? 55 : 0);

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + MediaQuery.of(context).viewPadding.bottom),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  if (widget.headerRenderFunc != null) ...[widget.headerRenderFunc!()],
                  if (widget.image != null)
                    SizedBox(
                      width: (widget.imageWidth != null) ? widget.imageWidth : double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32, top: widget.isDismissible ? 32 : 12),
                        child: widget.image,
                      ),
                    ),
                  Container(
                    padding: widget.padding,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(
                          child: WeatherText.title(
                            key: Key("common_modal_title"),
                            widget.title,
                            textAlign: widget.titleTextAlign,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            isTitle: true,
                          ),
                        ),
                        if (!hasImage) ...{
                          const SizedBox(width: 32),
                        }
                      ]),
                      Padding(
                        padding: widget.paddingAroundContentRenderFunc,
                        child: (widget.contentRenderFunc != null)
                            ? widget.contentRenderFunc!()
                            : WeatherText.body(
                                key: Key("common_modal_title"),
                                widget.content,
                                textAlign: widget.contentTextAlign,
                                fontSize: widget.contentFontSize ?? 15,
                                color: widget.contentColor ?? Color(0xFF1F1F1F),
                                lineHeight: 14,
                              ),
                      ),
                      WeatherText.body("Last day precipitation: $lastDayPrecipitation mm"),
                      SizedBox(height: 36),
                      SizedBox(
                          height: modalBottomSpace), // without this, the bottom part will be hidden by the button(s)
                    ]),
                  )
                ]),
              ),
              if (widget.crossIconOverImage == true)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      iconSize: 36,
                      icon: CustomImages.closeIcon,
                      onPressed: handlerClosedClick,
                      key: Key("close_icon"),
                    ),
                  ),
                ),
              if (widget.primaryButton != null || widget.secondaryButton != null)
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewPadding.bottom),
                    width: MediaQuery.of(context).size.width,
                    decoration: widget.decorationNeeded
                        ? BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, -1),
                              ),
                            ],
                          )
                        : null,
                    child: widget.buttonDirection == ModalButtonDirection.vertical
                        ? Column(
                            children: [
                              if (widget.primaryButton != null) buildPrimaryButton(18),
                              if (widget.primaryButton != null && widget.secondaryButton != null)
                                SizedBox(height: widget.primarySecondaryButtonMargin ?? 12),
                            ],
                          )
                        : Row(
                            children: [
                              if (widget.primaryButton != null)
                                Expanded(child: buildPrimaryButton(16)),
                            ],
                          ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.isDismissible && !widget.crossIconOverImage)
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: IconButton(
                  onPressed: handlerClosedClick,
                  color: Color(0xFFF8F8FA),
                  icon: CustomImages.closeIcon,
                ),
              ),
            ],
          ),
      ],
    );
  }

  WeatherButton buildPrimaryButton(double customFontSize) {
    return WeatherButton(
      key: Key("common_modal_primary_button"),
      verticalMargin: 0,
      onPressed: widget.showPrimaryButtonLoader
          ? () async {
              setState(() {
                primaryButtonIsLoading = true;
              });
              await widget.primaryButton!.onClicked();
              if (mounted) {
                setState(() {
                  primaryButtonIsLoading = false;
                });
              }
            }
          : widget.primaryButton!.onClicked,
      a11yLabel: widget.primaryButton!.a11y,
      label: widget.primaryButton!.text,
      customBackgroundColor: widget.primaryButton!.backgroundColor,
      isLoading: primaryButtonIsLoading,
      leading: widget.primaryButton!.leadingIcon,
      customFontSize: customFontSize,
    );
  }
}

class ModalButton {
  final String text;
  final String a11y;
  final FutureOr<void> Function() onClicked;
  final Color? backgroundColor;
  final Widget? leadingIcon;

  ModalButton(
    this.text,
    this.a11y,
    this.onClicked, {
    this.backgroundColor = const Color.fromARGB(255, 42, 187, 250),
    this.leadingIcon,
  });
}

enum ModalButtonDirection {
  horizontal,
  vertical,
}