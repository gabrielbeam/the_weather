import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather/common/bottom_navigation_item.dart';
import 'package:the_weather/common/custom_image.dart';
import 'package:the_weather/utils/constants.dart';
import 'package:the_weather/utils/navigator_helper.dart';
import 'package:the_weather/utils/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum BottomNavigatorItem {
  HOME,
  MAP,
  CHAT,
  MENU,
}

enum BottomNavigatorTargetRoute {
  HOME("/"),
  MAP("/map"),
  CHAT("/chat"),
  MENU("/menu/");

  const BottomNavigatorTargetRoute(this.route);
  final String route;
}

class BottomNavigator extends ConsumerStatefulWidget {
  const BottomNavigator();

  @override
  ConsumerState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends ConsumerState<BottomNavigator> {
  BottomNavigatorItem _getCurrentBottomNavigatorItem(String? currentRoute) {
    if (currentRoute == '/') {
      return BottomNavigatorItem.HOME;
    }
    if (currentRoute == '/${RoutePaths.map.name.toString()}/') {
      return BottomNavigatorItem.MAP;
    }
    if (currentRoute == '/${RoutePaths.chat.name.toString()}/') {
      return BottomNavigatorItem.CHAT;
    }
    return BottomNavigatorItem.MENU;
  }

  void _onItemClick(BottomNavigatorItem bottomNavigatorItem,
      BottomNavigatorItem currentBottomNavigatorItem) {
    if (bottomNavigatorItem == currentBottomNavigatorItem) {
      return;
    }
    switch (bottomNavigatorItem) {
      case BottomNavigatorItem.HOME:
        Modular.to.navigate('/');
        break;
      case BottomNavigatorItem.MAP:
        Modular.to.maybePop();
        Modular.to.pushNamed('/${RoutePaths.map.name.toString()}/');
        break;
      case BottomNavigatorItem.CHAT:
        Modular.to.maybePop();
        Modular.to.pushNamed('/${RoutePaths.chat.name.toString()}/');
        break;
      case BottomNavigatorItem.MENU:
        // See if commenting it out causes any issues
        // Modular.to.maybePop();
        Modular.to.pushNamed('/${RoutePaths.menu.name.toString()}/');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final currentRoute = NavigatorHelper.getCurrentRoute();
    final currentBottomNavigatorItem =
        _getCurrentBottomNavigatorItem(currentRoute);
    const double navigatorBottomGap = 5;
    const double navigatorHorizontalGap = 10;

    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 8,
        )
      ]),
      height: bottomNavigationHeight + navigatorBottomGap,
      child: Stack(children: [
        Positioned(
            bottom: navigatorBottomGap,
            left: navigatorHorizontalGap,
            right: navigatorHorizontalGap,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      )
                    ]),
                    child: SizedBox(
                      width: size.width,
                      height: bottomNavigationHeight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                              alignment: AlignmentDirectional.center,
                              width: size.width,
                              height: bottomNavigationHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: BottomNavigationItem(
                                      key: Key('bottomNavigatorItemHome'),
                                      title: 'Home',
                                      titleImage: currentBottomNavigatorItem ==
                                              BottomNavigatorItem.HOME
                                          ? CustomImages.homeImageActive
                                          : CustomImages.homeImage,
                                      titleStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, height: 1.4)
                                          .copyWith(
                                        color: currentBottomNavigatorItem ==
                                                BottomNavigatorItem.HOME
                                            ? Color(0xFF7437FF)
                                            :  Color(0xFF666666),
                                      ),
                                      onTap: () {
                                        _onItemClick(BottomNavigatorItem.HOME,
                                            currentBottomNavigatorItem);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: BottomNavigationItem(
                                      key: Key('bottomNavigatorItemMap'),
                                      title: 'Map',
                                      titleImage: currentBottomNavigatorItem ==
                                              BottomNavigatorItem.MAP
                                          ? CustomImages.mapImageActive
                                          : CustomImages.mapImage,
                                      titleStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, height: 1.4)
                                          .copyWith(
                                        color: currentBottomNavigatorItem ==
                                                BottomNavigatorItem.MAP
                                            ? Color(0xFF7437FF)
                                            :  Color(0xFF666666),
                                      ),
                                      onTap: () {
                                        _onItemClick(BottomNavigatorItem.MAP,
                                            currentBottomNavigatorItem);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: BottomNavigationItem(
                                      key: Key('bottomNavigatorItemChat'),
                                      title: 'Chat',
                                      titleImage: currentBottomNavigatorItem ==
                                              BottomNavigatorItem.CHAT
                                          ? CustomImages.chatImageActive
                                          : CustomImages.chatImage,
                                      titleStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, height: 1.4)
                                          .copyWith(
                                        color: currentBottomNavigatorItem ==
                                                BottomNavigatorItem.CHAT
                                            ? Color(0xFF7437FF)
                                            :  Color(0xFF666666),
                                      ),
                                      onTap: () {
                                        _onItemClick(BottomNavigatorItem.CHAT,
                                            currentBottomNavigatorItem);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: BottomNavigationItem(
                                      key: Key('bottomNavigatorItemMenu'),
                                      title: 'Menu',
                                      titleImage: currentBottomNavigatorItem ==
                                              BottomNavigatorItem.MENU
                                          ? CustomImages.menuImageActive
                                          : CustomImages.menuImage,
                                      titleStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, height: 1.4)
                                          .copyWith(
                                        color: currentBottomNavigatorItem ==
                                                BottomNavigatorItem.MENU
                                            ? Color(0xFF7437FF)
                                            :  Color(0xFF666666),
                                      ),
                                      onTap: () {
                                        _onItemClick(BottomNavigatorItem.MENU,
                                            currentBottomNavigatorItem);
                                      },
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )),
              ],
            ))
      ]),
    );
  }
}
