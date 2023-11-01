import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/shared_prefs_service.dart';

final sharedPrefsServiceProvider = Provider((ref) {
  final SharedPrefsService prefsService = SharedPrefsService();
  prefsService.init();
  return prefsService;
});
