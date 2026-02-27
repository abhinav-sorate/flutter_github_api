part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SearchUsers extends UserEvent {
  final String keyword;
  const SearchUsers({required this.keyword});
}

class GetUserDetails extends UserEvent {
  final String username;
  const GetUserDetails({required this.username});
}

class GetUserRepos extends UserEvent {
  final String username;
  const GetUserRepos({required this.username});
}
