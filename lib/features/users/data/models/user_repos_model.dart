import 'package:flutter_github_api/features/users/domain/entities/user_repo_entity.dart';

class UserReposModel {
  final String name;
  final String language;
  final int stars;
  final String description;
  final String htmlUrl;
  final bool isFork;

  UserReposModel({
    required this.name,
    required this.language,
    required this.stars,
    required this.description,
    required this.htmlUrl,
    required this.isFork,
  });

  factory UserReposModel.fromJson(Map<String, dynamic> json) {
    return UserReposModel(
      name: json['name'] as String,
      language: json['language'] as String,
      stars: json['stars'] as int,
      description: json['description'] as String,
      htmlUrl: json['html_url'] as String,
      isFork: json['isFork'] as bool,
    );
  }

  UserRepoEntity toEntity() {
    return UserRepoEntity(
      name: name,
      language: language,
      stars: stars,
      description: description,
      url: htmlUrl,
    );
  }
}
