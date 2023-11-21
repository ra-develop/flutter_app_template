import 'package:app_template/core/data/datasources/local/shared_prefs_service.dart';
import 'package:app_template/core/services/auth_service/user_cache_service/data/models/user/user_model.dart';
import 'package:app_template/core/services/storage/local/storage_service.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/data/user_map.dart';
import '../../../fixtures/dummy_data.dart';
import 'shared_prefs_storage_service_test.mapper.g.dart';

void main() {
  late StorageService storageService;

  setUp(() {
    initializeJsonMapper();
  });

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({'key': ktestUserMap});
    storageService = SharedPrefsService();
  });

  test(
    'When the prefs is not initialized the hasInitialized should be FALSE',
        () async {
      expect(storageService.hasInitialized, false);

      final isInitiated = await storageService.init();

      expectLater(isInitiated, true);
    },
  );

  group(
    'SharedPreferencesStorageServiceTests\n',
        () {
      group("Should perform the CRUD operations with SharedPreferences\n", () {
        const testData = "testing data string";
        test('save the data', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }
          // save the data again
          final saved = await storageService.set('key', testData);

          expect(saved, true);
          // check if data exist
          // should return true
          final hasData = await storageService.has('key');

          expect(hasData, true);
        });

        test('Check if data exist', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }
          // check if data exist
          // should return true
          final hasData = await storageService.has('key');

          expect(hasData, true);
        });
        test('get the data', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }
          // get the data
          final data = await storageService.get('key');

          expect(data, testData);
        });

        test('Remove the data', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }
          // remove the data
          final removeData = await storageService.remove('key');

          expect(removeData, true);

          // check if data exist
          // should return false
          final hasData2 = await storageService.has('key');

          expect(hasData2, false);
        });
        test('Check if data exist after remove all', () async {
          // clear the shared preferences
          await storageService.clear();

          // check if data exist
          // should return false
          final hasData4 = await storageService.has('key');

          expect(hasData4, false);
        });
      });

      group("Should perform the different data with SharedPreferences\n", () {
        test('save the integer data', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }

          const testData = 12345;
          // save the data again
          final saved = await storageService.set('key', testData);
          expect(saved, true);

          final getData = await storageService.get('key');
          expect(getData, testData);
        });
        test('save the double data', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }

          const testData = 12.345;
          // save the data again
          final saved = await storageService.set('key', testData);

          expect(saved, true);
        });
        test('save the string data', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }

          const testData = "12345";
          // save the data again
          final saved = await storageService.set('key', testData);
          expect(saved, true);

          final getData = await storageService.get('key');
          expect(getData, testData);
        });

        test('save the boolean data', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }

          const testData = true;
          // save the data again
          final saved = await storageService.set('key', testData);
          expect(saved, true);

          final getData = await storageService.get('key');
          expect(getData, testData);
        });

        test('save the map data as string ', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }

          final testData = ktestUserMap;
          // save the map data again
          final saved = await storageService.set('key', testData);
          expect(saved, true);

          final getData = await storageService.get('key');
          expect(getData, ktestUserJson);
        });

        test('save the jsonSerializable data class as string', () async {
          if (!storageService.hasInitialized) {
            await storageService.init();
          }

          final testData = ktestUser;
          // save jsonSerializable data class data again
          final saved = await storageService.set('key', testData);
          expect(saved, true);

          final getData = await storageService.get('key');
          final user = JsonMapper.deserialize<User>(getData);
          expect(user, testData);
        });
      });
    },
  );
}
