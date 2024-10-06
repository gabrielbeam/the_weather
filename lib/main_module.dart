
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather/chat/chat_module.dart';
import 'package:the_weather/home/home_module.dart';
import 'package:the_weather/map/map_module.dart';
import 'package:the_weather/menu/menu_module.dart';
import 'package:the_weather/utils/routes.dart';

class AppModule extends Module {
  final ProviderContainer ref;

  AppModule(this.ref);

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule(), transition: TransitionType.noTransition),
        ModuleRoute('/${RoutePaths.map.name.toString()}', module: MapModule()),
        ModuleRoute('/${RoutePaths.chat.name.toString()}', module: ChatModule()),
        ModuleRoute('/${RoutePaths.menu.name.toString()}', module: MenuModule()),
      ];
}