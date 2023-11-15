import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/providers/auth_providers.dart';
import '../../features/authentication/presentation/providers/state/auth_state.dart';
import '../../features/authentication/presentation/views/login_screen.dart';
import '../../features/demo/presentation/views/demo_page.dart';
import '../share/widgets/waiting_view.dart';

enum AppRoute { appHome, simpleWait, waitingView, login }

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: navigatorKey,

    /// Forwards diagnostic messages to the dart:developer log() API.
    debugLogDiagnostics: true,

    /// Initial Routing Location
    initialLocation: '/',

    /// The listeners are typically used to notify clients that the object has been
    /// updated.
    // refreshListenable: authState,

    routes: [
      // GoRoute(
      //   path: '/${AppRoute.splash.name}',
      //   name: AppRoute.splash.name,
      //   builder: (context, state) {
      //     return const SplashPage();
      //   },
      // ),
      GoRoute(
        path: '/',
        name: AppRoute.appHome.name,
        builder: (context, state) {
          return const DemoPage(title: 'Flutter Demo Page');
        },
      ),
      GoRoute(
        path: '/${AppRoute.login.name}',
        name: AppRoute.login.name,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: '/${AppRoute.simpleWait.name}',
        name: AppRoute.simpleWait.name,
        builder: (context, state) {
          final message = state.extra as String;
          return WaitingView(
            message: message,
          );
        },
      ),
      GoRoute(
        path: '/${AppRoute.waitingView.name}',
        name: AppRoute.waitingView.name,
        builder: (context, state) {
          final waitingViewArgs = state.extra as WaitingViewArgs;
          return WaitingView(
            message: waitingViewArgs.message,
            duration: waitingViewArgs.duration,
            infoIcon: waitingViewArgs.infoIcon,
            linearMode: waitingViewArgs.linearMode,
          );
        },
      ),
    ],
    redirect: (context, state) {
      /**
       * Your Redirection Logic Code  Here..........
       */

      if (authState.state is Success) {
        return null;
      } else {
        return '/${AppRoute.login.name}';
      }
    },
  );
});
