class UserDetailsEntity {
  final String avatarUrl;
  final String username;
  final String fullname;
  final int followers;
  final int following;
  final String type;

  const UserDetailsEntity({
    required this.avatarUrl,
    required this.username,
    required this.fullname,
    required this.followers,
    required this.following,
    required this.type,
  });
}
