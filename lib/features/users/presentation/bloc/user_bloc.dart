import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_details_entity.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_repo_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/features/users/domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  UserBloc(this._userRepo) : super(UserState()) {
    on<SearchUsers>(
      _searchUsers,
      transformer: debounce(const Duration(milliseconds: 1000)),
    );
    on<LoadMoreUsers>(_loadMoreUsers);

    on<GetUserDetails>(_getUserDetails);

    on<GetUserRepos>(_getUserRepos);
  }

  Future<void> _searchUsers(SearchUsers event, Emitter<UserState> emit) async {
    final keyword = event.keyword.trim();

    if (keyword.isEmpty) {
      emit(
        state.copyWith(
          getUserSearchStatus: ApiStatus.initial,
          userSearchList: [],
        ),
      );
      return;
    }

    emit(state.copyWith(getUserSearchStatus: ApiStatus.loading));

    final users = await _userRepo.searchUsers(keyword: keyword, page: 1);

    // handle empty list in case user not found
    if (users.data != null && users.data!.isEmpty) {
      emit(
        state.copyWith(
          getUserSearchStatus: ApiStatus.notFound,
          userSearchList: [],
        ),
      );
      return;
    }

    if (users.data != null) {
      emit(
        state.copyWith(
          getUserSearchStatus: ApiStatus.success,
          userSearchList: users.data,
          searchPage: 1,
          hasMoreSearch: users.data!.length == 30,
          keyword: keyword,
        ),
      );
      return;
    }

    emit(state.copyWith(getUserSearchStatus: ApiStatus.error));
  }

  Future<void> _loadMoreUsers(
    LoadMoreUsers event,
    Emitter<UserState> emit,
  ) async {
    if (!state.hasMoreSearch || state.isSearchLoadMore) return;

    emit(state.copyWith(isSearchLoadMore: true));

    final nextPage = state.searchPage + 1;
    final result = await _userRepo.searchUsers(
      keyword: state.keyword,
      page: nextPage,
    );

    if (result.data != null && result.data!.isNotEmpty) {
      emit(
        state.copyWith(
          userSearchList: [...state.userSearchList, ...result.data!],
          searchPage: nextPage,
          hasMoreSearch: result.data!.length >= 30,
          isSearchLoadMore: false,
        ),
      );
    } else {
      emit(state.copyWith(hasMoreSearch: false, isSearchLoadMore: false));
    }
  }

  Future<void> _getUserDetails(
    GetUserDetails event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(getUserDetailsStatus: ApiStatus.loading));

    final user = await _userRepo.getUserDetails(username: event.username);

    if (user.data != null) {
      emit(
        state.copyWith(
          getUserDetailsStatus: ApiStatus.success,
          userDetails: user.data,
        ),
      );
    } else {
      emit(state.copyWith(getUserDetailsStatus: ApiStatus.error));
    }
  }

  Future<void> _getUserRepos(
    GetUserRepos event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(getUserReposStatus: ApiStatus.loading));

    final repos = await _userRepo.getUserRepos(username: event.username);

    if (repos.data != null) {
      emit(
        state.copyWith(
          getUserReposStatus: ApiStatus.success,
          userRepoList: repos.data,
        ),
      );
    } else {
      emit(state.copyWith(getUserReposStatus: ApiStatus.error));
    }
  }
}
