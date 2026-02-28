import 'package:equatable/equatable.dart';

class UserRepoEntity extends Equatable {
  final String name;
  final String? language;
  final int stars;
  final String? description;
  final String url;

  const UserRepoEntity({
    required this.name,
    this.language,
    required this.stars,
    this.description,
    required this.url,
  });

  @override
  List<Object?> get props => [name, language, stars, description, url];
}
