part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.getUserSearchStatus = ApiStatus.initial,
    this.userSearchList = const <UserListEntity>[],
  });

  final ApiStatus getUserSearchStatus;
  final List<UserListEntity> userSearchList;

  UserState copyWith({
    ApiStatus? getUserSearchStatus,
    List<UserListEntity>? userSearchList,
  }) {
    return UserState(
      getUserSearchStatus: getUserSearchStatus ?? this.getUserSearchStatus,
      userSearchList: userSearchList ?? this.userSearchList,
    );
  }

  @override
  List<Object> get props => [getUserSearchStatus, userSearchList];
}
