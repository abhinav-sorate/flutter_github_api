class UserRepoEntity {
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
}
