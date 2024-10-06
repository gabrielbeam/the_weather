import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:the_weather/common/global_loadin_provided.dart';
import 'package:the_weather/main_module.dart';
import 'package:the_weather/theme/theme.dart';
import 'package:the_weather/theme/theme_mode_provider.dart';

void main() async {
  final container = ProviderContainer();
  await dotenv.load(fileName: ".env");
  await runBaseApp(container);
}

Future<void> runBaseApp(ProviderContainer container) async {
  runApp(
    ModularApp(
      module: AppModule(container),
      child: UncontrolledProviderScope(
        container: container,
        child: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: overlay(),
          overlayColor: Colors.black,
          child: const AppContainer(),
        ),
      ),
    ),
  );
}

class AppContainer extends ConsumerStatefulWidget {
  const AppContainer({super.key});

  @override
  ConsumerState createState() => _AppContainerState();
}

class _AppContainerState extends ConsumerState<AppContainer> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'from yoyo');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoadingProviderState>(globalLoadingProvider, (previous, next) {
      if (previous == next) return;
      if (next.loading == true) {
        context.loaderOverlay.show(widget: overlay(text: next.text));
      } else {
        context.loaderOverlay.hide();
      }
    });

    return MaterialApp(
      builder: (context, _) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MediaQuery(
          // Hardcode text scale to be independent from user's system font setting
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: MaterialApp.router(
            useInheritedMediaQuery: true,
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate..setNavigatorKey(_navigatorKey),
            builder: FToastBuilder(),
            title: "Weather Master",
            themeMode: ref.watch(themeModeProvider),
            theme: lightTheme(),
          ),
        ),
      ),
    );
  }
}
