import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/providers/dio_network_service_provider.dart';
import '../../../../core/services/storage/remote/network_service.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/repositories/atuhentication_repository_impl.dart';
import '../repositories/auth_repository.dart';

final authdataSourceProvider =
    Provider.family<LoginUserDataSource, NetworkService>(
  (_, networkService) => LoginUserRemoteDataSource(networkService),
);

final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) {
    final NetworkService networkService = ref.watch(netwokServiceProvider);
    final LoginUserDataSource dataSource =
        ref.watch(authdataSourceProvider(networkService));
    return AuthenticationRepositoryImpl(dataSource);
  },
);
