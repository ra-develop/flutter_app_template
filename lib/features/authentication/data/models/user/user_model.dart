import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@jsonSerializable
@Json(ignoreNullMembers: true)
@Entity()
class User extends Equatable {
  @Id()
  @JsonProperty(ignore: true)
  int objectboxid = 0;
  int id = 0;
  String username;
  String? password;
  String firstName;
  String lastName;
  String email;
  String gender;
  String image;
  String accessToken;

  User({
    this.objectboxid = 0,
    this.id = 0,
    this.username = '',
    this.password = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.image = '',
    this.accessToken = '',
  });

  @override
  @JsonProperty(ignore: true)
  bool get stringify => true;

  @override
  @JsonProperty(ignore: true)
  List<Object?> get props => [
        id,
        username,
        password,
        email,
        firstName,
        lastName,
        gender,
        image,
    accessToken,
      ];

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? accessToken,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
