import 'package:app_template/core/domain/providers/dio_network_service_provider.dart';
import 'package:app_template/core/services/storage/remote/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dioNetworkServiceProvider is a NetworkService', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(netwokServiceProvider),
      isA<NetworkService>(),
    );
  });
}
