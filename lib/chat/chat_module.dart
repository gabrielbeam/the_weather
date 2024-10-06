import 'package:flutter_modular/flutter_modular.dart';
import 'package:the_weather/chat/chat_screen.dart';

class ChatModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ChatScreen(),
        ),
      ];
}
