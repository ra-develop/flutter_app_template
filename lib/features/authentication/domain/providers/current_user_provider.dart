import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/user/user_model.dart';
import 'user_cache_provider.dart';

final currentUserProvider = FutureProvider<User?>((ref) async {
  final repository = ref.watch(userLocalRepositoryProvider);
  final eitherType = (await repository.fetchUser());

  return eitherType.fold((l) => null, (r) => r);
});
