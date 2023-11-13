import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/datasources/local/shared_prefs_service.dart';

final sharedPrefsServiceProvider = Provider((ref) {
  final SharedPrefsService prefsService = SharedPrefsService();
  prefsService.init();
  return prefsService;
});
