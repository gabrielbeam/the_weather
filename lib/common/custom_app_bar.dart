import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather/common/weather_text.dart';
import 'package:the_weather/utils/navigator_helper.dart';

class CustomAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Icon? leadingIcon;
  final List<Widget>? action;
  final bool automaticallyImplyLeading;
  final bool isShowShadowColor;
  final Color? backgroundColor;
  final double elevation;
  final bool inverse;
  final Function? onPressBack;
  final bool disableLeading;
  final double titleSpacing;
  final PreferredSizeWidget? bottom;
  final bool forceShowLeading;

  const CustomAppBar(
      {super.key,
      this.title = '',
      this.centerTitle = false,
      this.leadingIcon,
      this.action,
      this.automaticallyImplyLeading = true,
      this.isShowShadowColor = true,
      this.elevation = 4,
      this.inverse = false,
      this.onPressBack,
      this.disableLeading = false,
      this.titleSpacing = 0,
      this.bottom,
      this.forceShowLeading = false,
      this.backgroundColor})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize; // default is 56.0

  @override
  ConsumerState<CustomAppBar> createState() => CustomAppBarState();
}

/// Layout
const double leftSidePadding = 20;
const double leadingSize = 24;
const double leadingToTitleSpacing = 12;
const double leadingWidth = leftSidePadding + leadingSize + leadingToTitleSpacing;

class CustomAppBarState extends ConsumerState<CustomAppBar> {
  Widget buildLeadingIcon() {
    if (widget.disableLeading) {
      return Container();
    }
    return IconButton(
      padding: const EdgeInsets.only(
        left: leftSidePadding,
        right: leadingToTitleSpacing,
      ),
      key: Key("back_icon"),
      icon: widget.leadingIcon ?? const Icon(Icons.keyboard_backspace),
      color: const Color(0xFF1F1F1F),
      onPressed: widget.disableLeading
          ? null
          : () async {
              handleBackNavigation();
            },
    );
  }

  void handleBackNavigation() async {
    if (widget.onPressBack != null) {
      await widget.onPressBack!();
    } else {
      Modular.to.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = NavigatorHelper.canPop();
    final currentRoute = NavigatorHelper.getCurrentRoute();

    /// If page is loaded directly from home page, should show bottom navigator and hide back button
    bool fromHomePage =
        NavigatorHelper.isExactlyLastPreviousRoute("/");

    /// Hide shadow below AppBar if [isShowShadowColor] is false and not from home page
    bool showShadowBelowBar = widget.isShowShadowColor;

    return AppBar(
      automaticallyImplyLeading: fromHomePage ? false : widget.automaticallyImplyLeading,
      centerTitle: widget.centerTitle,
      backgroundColor: Colors.white,
      titleSpacing: widget.titleSpacing,
      leadingWidth: widget.disableLeading ? 12.0 : leadingWidth,
      leading: buildLeadingIcon(),
      shadowColor: Color(0x147347FF),
      title: WeatherText.title(
        widget.title,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1F1F1F),
      ),
      elevation: widget.elevation,
      actions: widget.action,
      bottom: widget.bottom,
    );
  }
}
