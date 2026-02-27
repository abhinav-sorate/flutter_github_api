part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.getUserSearchStatus = ApiStatus.initial,
    this.userSearchList = const <UserListEntity>[],

    this.getUserDetailsStatus = ApiStatus.initial,
    this.userDetails,
  });

  final ApiStatus getUserSearchStatus;
  final List<UserListEntity> userSearchList;

  final ApiStatus getUserDetailsStatus;
  final UserDetailsEntity? userDetails;

  UserState copyWith({
    ApiStatus? getUserSearchStatus,
    List<UserListEntity>? userSearchList,

    ApiStatus? getUserDetailsStatus,
    UserDetailsEntity? userDetails,
  }) {
    return UserState(
      getUserSearchStatus: getUserSearchStatus ?? this.getUserSearchStatus,
      userSearchList: userSearchList ?? this.userSearchList,

      getUserDetailsStatus: getUserDetailsStatus ?? this.getUserDetailsStatus,
      userDetails: userDetails ?? userDetails,
    );
  }

  @override
  List<Object?> get props => [
    getUserSearchStatus,
    userSearchList,

    getUserDetailsStatus,
    userDetails,
  ];
}
