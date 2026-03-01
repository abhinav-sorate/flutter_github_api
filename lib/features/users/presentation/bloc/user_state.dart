part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.getUserSearchStatus = ApiStatus.initial,
    this.userSearchList = const <UserListEntity>[],
    this.searchPage = 1,
    this.hasMoreSearch = true,
    this.isSearchLoadMore = false,
    this.keyword = '',

    this.getUserDetailsStatus = ApiStatus.initial,
    this.userDetails,

    this.getUserReposStatus = ApiStatus.initial,
    this.userRepoList = const <UserRepoEntity>[],
  });

  final ApiStatus getUserSearchStatus;
  final List<UserListEntity> userSearchList;
  final int searchPage;
  final bool hasMoreSearch;
  final bool isSearchLoadMore;
  final String keyword;

  final ApiStatus getUserDetailsStatus;
  final UserDetailsEntity? userDetails;

  final ApiStatus getUserReposStatus;
  final List<UserRepoEntity> userRepoList;

  UserState copyWith({
    ApiStatus? getUserSearchStatus,
    List<UserListEntity>? userSearchList,
    int? searchPage,
    bool? hasMoreSearch,
    bool? isSearchLoadMore,
    String? keyword,

    ApiStatus? getUserDetailsStatus,
    UserDetailsEntity? userDetails,

    ApiStatus? getUserReposStatus,
    List<UserRepoEntity>? userRepoList,
  }) {
    return UserState(
      getUserSearchStatus: getUserSearchStatus ?? this.getUserSearchStatus,
      userSearchList: userSearchList ?? this.userSearchList,
      searchPage: searchPage ?? this.searchPage,
      hasMoreSearch: hasMoreSearch ?? this.hasMoreSearch,
      isSearchLoadMore: isSearchLoadMore ?? this.isSearchLoadMore,
      keyword: keyword ?? this.keyword,

      getUserDetailsStatus: getUserDetailsStatus ?? this.getUserDetailsStatus,
      userDetails: userDetails ?? this.userDetails,

      getUserReposStatus: getUserReposStatus ?? this.getUserReposStatus,
      userRepoList: userRepoList ?? this.userRepoList,
    );
  }

  @override
  List<Object?> get props => [
    getUserSearchStatus,
    userSearchList,
    searchPage,
    hasMoreSearch,
    isSearchLoadMore,
    keyword,

    getUserDetailsStatus,
    userDetails,

    getUserReposStatus,
    userRepoList,
  ];
}
