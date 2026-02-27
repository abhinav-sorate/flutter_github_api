class UserListModel {
  final String avatarUrl;
  final String username;
  final String type;
  final int id;

  UserListModel({
    required this.avatarUrl,
    required this.username,
    required this.type,
    required this.id,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      avatarUrl: json['avatar_url'] as String,
      username: json['login'] as String,
      type: json['type'] as String,
      id: json['id'] as int,
    );
  }
}
