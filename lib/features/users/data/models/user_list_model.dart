import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';

class UserListModel {
  final String avatarUrl;
  final String login;
  final String type;
  final int id;

  UserListModel({
    required this.avatarUrl,
    required this.login,
    required this.type,
    required this.id,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      avatarUrl: json['avatar_url'] as String,
      login: json['login'] as String,
      type: json['type'] as String,
      id: json['id'] as int,
    );
  }

  UserListEntity toEntity() {
    return UserListEntity(
      avatarUrl: avatarUrl,
      username: login,
      type: type,
      id: id,
    );
  }
}
