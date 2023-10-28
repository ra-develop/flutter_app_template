import 'package:flutter/material.dart';

import '../../features/authentication/presentation/views/login_screen.dart';
import '../../features/demo/presentation/views/demo_page.dart';
import '../share/widgets/waiting_view.dart';

class AppRoutes {
  static const appHome = '/appHomepage';
  static const simpleWait = "/simpleWait";
  static const waitingView = "/waitingView";
  static const login = '/login';

  String getInitialRoute() => AppRoutes.login;

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.simpleWait:
        final message = settings.arguments as String?;
        return _buildRoute(
            WaitingView(
              message: message,
            ),
            settings: settings);

      case AppRoutes.waitingView:
        final args = settings.arguments;
        if (args == null) {
          throw Exception('[AppRoutes]: Route arguments are required');
        }
        final waitingViewArgs = args as WaitingViewArgs;
        return _buildRoute(
            WaitingView(
              message: waitingViewArgs.message,
              duration: waitingViewArgs.duration,
              infoIcon: waitingViewArgs.infoIcon,
              linearMode: waitingViewArgs.linearMode,
            ),
            settings: settings);

      case AppRoutes.login:
        return _buildRoute(LoginScreen(), settings: settings);

      case AppRoutes.appHome:
        return _buildRoute(const DemoPage(title: 'Flutter Demo Page'),
            settings: settings);

      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(Widget child, {RouteSettings? settings}) =>
      MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => child,
      );
}
