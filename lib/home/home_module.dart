import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_weather/home/home_screen.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => HomeScreen(),
        ),
      ];
}
