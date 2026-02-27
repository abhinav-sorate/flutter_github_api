import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_api/core/constants/status.enum.dart';
import 'package:flutter_github_api/core/locator.dart';
import 'package:flutter_github_api/core/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<SearchUsers>(_searchUsers);
  }

  Future<void> _searchUsers(SearchUsers event, Emitter<UserState> emit) async {
    emit(state.copyWith(getUserSearchStatus: ApiStatus.initial));
    try {
      emit(state.copyWith(getUserSearchStatus: ApiStatus.loading));
      final response = await locator<UserRepo>().searchUsers(
        keyword: event.keyword,
      );
      emit(state.copyWith(userSearchList: response.data));
    } catch (e) {
      emit(state.copyWith(getUserSearchStatus: ApiStatus.error));
    }
  }
}
