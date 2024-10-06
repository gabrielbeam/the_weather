import 'package:flutter_modular/flutter_modular.dart';

class NavigatorHelper {
  static bool isExactlyLastPreviousRoute(String route) {
    final List<ParallelRoute> history = Modular.to.navigateHistory;

    if (history.length >= 2) {
      return history[history.length - 2].name == route;
    }

    return false;
  }

  static String getCurrentRoute() {
    final List<ParallelRoute> history = Modular.to.navigateHistory;

    if (history.isEmpty) {
      return "";
    }

    return history.last.name;
  }

  static bool canPop() {
    final List<ParallelRoute> history = Modular.to.navigateHistory;

    if (history.length <= 1) {
      return false;
    }

    return true;
  }
}