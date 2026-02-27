import 'package:flutter_github_api/features/users/domain/entities/user_details_entity.dart';

class UserDetailsModel {
  final String avatarUrl;
  final String login;
  final String name;
  final int followers;
  final int following;

  UserDetailsModel({
    required this.avatarUrl,
    required this.login,
    required this.name,
    required this.followers,
    required this.following,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      avatarUrl: json['avatar_url'] as String,
      login: json['login'] as String,
      name: json['name'] as String,
      followers: json['followers'] as int,
      following: json['following'] as int,
    );
  }

  UserDetailsEntity toEntity() {
    return UserDetailsEntity(
      avatarUrl: avatarUrl,
      username: login,
      fullname: name,
      followers: followers,
      following: following,
    );
  }
}
