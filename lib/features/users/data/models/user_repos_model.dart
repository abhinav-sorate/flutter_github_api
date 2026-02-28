import 'package:flutter_github_api/features/users/domain/entities/user_repo_entity.dart';

class UserReposModel {
  final String name;
  final String? language;
  final int stars;
  final String? description;
  final String htmlUrl;
  final bool fork;

  UserReposModel({
    required this.name,
    this.language,
    required this.stars,
    this.description,
    required this.htmlUrl,
    required this.fork,
  });

  factory UserReposModel.fromJson(Map<String, dynamic> json) {
    return UserReposModel(
      name: json['name'] as String,
      language: json['language'] as String?,
      stars: (json['stargazers_count'] as num).toInt(),
      description: json['description'] as String?,
      htmlUrl: json['html_url'] as String,
      fork: json['fork'] as bool? ?? false,
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
