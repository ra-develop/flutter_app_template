import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/routes/app_router.dart';
import 'theme/theme.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  // This widget is the root of application.

  // TODO to set app title
  final title = 'Flutter App Template';

  // @override
  // initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
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
      routerConfig: router,
    );
  }
}
