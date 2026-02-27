import 'package:equatable/equatable.dart';

class UserListEntity extends Equatable {
  final String avatarUrl;
  final String username;
  final String type;
  final int id;

  const UserListEntity({
    required this.avatarUrl,
    required this.username,
    required this.type,
    required this.id,
  });

  @override
  List<Object> get props => [avatarUrl, username, type, id];
}
