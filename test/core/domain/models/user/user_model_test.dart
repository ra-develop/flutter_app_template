import 'package:app_template/core/domain/models/user/user_model.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/data/user_map.dart';
import '../../../../fixtures/dummy_data.dart';
import 'user_model_test.mapper.g.dart';

void main() {
  initializeJsonMapper();
  group(
    'UserModel Test\n',
    () {
      test('Should parse User from json', () {
        final user = JsonMapper.fromJson<User>(ktestUserJson);
        expect(user, ktestUser);
      });

      test('Should return json string from user', () {
        final json = JsonMapper.toJson(ktestUser);
        expect(json, ktestUserJson);
      });
      test('Should return map of user', () {
        final userMap = JsonMapper.toMap(ktestUser);
        expect(userMap, isA<Map<String, dynamic>>());
      });
      test('Should update value by copyWith', () {
        const String updatedToken = 'updated';

        User user = ktestUser.copyWith(token: updatedToken);
        expect(user.token, updatedToken);

        user = user.copyWith(token: null);
        expect(user.token, updatedToken);
      });
    },
  );
}
