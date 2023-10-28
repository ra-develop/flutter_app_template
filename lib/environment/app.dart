import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/routes/app_routes.dart';
import 'theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of application.

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO to set app title
    const title = 'Flutter App Template';
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: title,
      theme: AppTheme().lightBase,
      darkTheme: AppTheme().darkBase,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it'),
        Locale('it', 'IT'),
        Locale('en'),
        // Locale('es', ''),
        // Locale('fr', ''),
        // ...
      ],
      locale: ui.window.locale,
      //const Locale('en'),
      localeListResolutionCallback: (locales, supportedLocales) {
        if (locales != null) {
          for (Locale locale in locales) {
            // if device language is supported by the app,
            // just return it to set it as current app language
            if (supportedLocales.contains(locale)) {
              return locale;
            }
          }
        }
        return const Locale('en', '');
      },
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        } else {
          return const Locale('en', '');
        }
      },
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes().getInitialRoute(),
      onGenerateRoute: (route) => AppRoutes().getRoute(route),
    );
  }
}
