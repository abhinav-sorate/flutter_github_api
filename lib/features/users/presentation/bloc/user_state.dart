part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.getUserSearchStatus = ApiStatus.initial,
    this.userSearchList = const <UserListEntity>[],

    this.getUserDetailsStatus = ApiStatus.initial,
    this.userDetails,

    this.getUserReposStatus = ApiStatus.initial,
    this.userRepoList = const <UserRepoEntity>[]
  });

  final ApiStatus getUserSearchStatus;
  final List<UserListEntity> userSearchList;

  final ApiStatus getUserDetailsStatus;
  final UserDetailsEntity? userDetails;

  final ApiStatus getUserReposStatus;
  final List<UserRepoEntity> userRepoList;

  UserState copyWith({
    ApiStatus? getUserSearchStatus,
    List<UserListEntity>? userSearchList,

    ApiStatus? getUserDetailsStatus,
    UserDetailsEntity? userDetails,

    ApiStatus? getUserReposStatus,
    List<UserRepoEntity>? userRepoList,
  }) {
    return UserState(
      getUserSearchStatus: getUserSearchStatus ?? this.getUserSearchStatus,
      userSearchList: userSearchList ?? this.userSearchList,

      getUserDetailsStatus: getUserDetailsStatus ?? this.getUserDetailsStatus,
      userDetails: userDetails ?? userDetails,

      getUserReposStatus: getUserReposStatus ?? this.getUserReposStatus,
      userRepoList: userRepoList ?? this.userRepoList,
    );
  }

  @override
  List<Object?> get props => [
    getUserSearchStatus,
    userSearchList,

    getUserDetailsStatus,
    userDetails,

    getUserReposStatus,
    userRepoList
  ];
}
