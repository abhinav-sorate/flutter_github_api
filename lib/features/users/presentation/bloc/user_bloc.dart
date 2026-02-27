import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';
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
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _searchUsers(SearchUsers event, Emitter<UserState> emit) async {
    emit(state.copyWith(getUserSearchStatus: ApiStatus.loading));

    final users = await _userRepo.searchUsers(keyword: event.keyword);

    if (users.data != null) {
      emit(
        state.copyWith(
          getUserSearchStatus: ApiStatus.success,
          userSearchList: users.data,
        ),
      );
    } else {
      emit(state.copyWith(getUserSearchStatus: ApiStatus.error));
    }
  }
}
