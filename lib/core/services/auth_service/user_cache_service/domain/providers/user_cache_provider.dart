import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../domain/providers/shared_prefs_service_provider.dart';
import '../../../../storage/local/storage_service.dart';
import '../../data/datasource/user_local_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../repositories/user_cache_repository.dart';

final userDatasourceProvider = Provider.family<UserDataSource, StorageService>(
  (_, networkService) => UserLocalDatasource(networkService),
);

final userLocalRepositoryProvider = Provider<UserRepository>((ref) {
  final storageService = ref.watch(sharedPrefsServiceProvider);

  final datasource = ref.watch(userDatasourceProvider(storageService));

  final respository = UserRepositoryImpl(datasource);

  return respository;
});
