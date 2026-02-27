part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.getUserSearchStatus = ApiStatus.initial,
    this.userSearchList = const <UserListModel>[],
  });

  final ApiStatus getUserSearchStatus;
  final List<UserListModel> userSearchList;

  UserState copyWith({
    ApiStatus? getUserSearchStatus,
    List<UserListModel>? userSearchList,
  }) {
    return UserState(
      getUserSearchStatus: getUserSearchStatus ?? this.getUserSearchStatus,
      userSearchList: userSearchList ?? this.userSearchList,
    );
  }

  @override
  List<Object> get props => [getUserSearchStatus, userSearchList];
}
