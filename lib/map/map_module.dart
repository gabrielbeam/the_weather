import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_weather/map/map_screen.dart';

class MapModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => MapScreen(),
        ),
      ];
}
