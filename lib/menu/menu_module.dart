import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_weather/menu/menu_screen.dart';

class MenuModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => MenuScreen(),
        ),
      ];
}
