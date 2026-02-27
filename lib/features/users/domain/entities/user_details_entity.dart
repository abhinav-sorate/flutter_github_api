import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String avatarUrl;
  final String username;
  final String fullname;
  final int followers;
  final int following;

  const UserDetailsEntity({
    required this.avatarUrl,
    required this.username,
    required this.fullname,
    required this.followers,
    required this.following,
  });

  @override
  List<Object> get props => [
    avatarUrl,
    username,
    fullname,
    followers,
    following,
  ];
}
