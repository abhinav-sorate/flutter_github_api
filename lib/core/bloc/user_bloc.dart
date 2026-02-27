import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/core/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo _userRepo;
  UserBloc(this._userRepo) : super(UserState()) {
    on<SearchUsers>(_searchUsers);
  }

  Future<void> _searchUsers(SearchUsers event, Emitter<UserState> emit) async {
    emit(state.copyWith(getUserSearchStatus: ApiStatus.loading));

    final result = await _userRepo.searchUsers(keyword: event.keyword);

    if (result.data != null) {
      final items = result.data.data['items'] as List;

      emit(
        state.copyWith(
          getUserSearchStatus: ApiStatus.success,
          userSearchList: items,
        ),
      );
    } else {
      emit(state.copyWith(getUserSearchStatus: ApiStatus.error));
    }
  }
}
