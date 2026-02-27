part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.getUserSearchStatus = ApiStatus.initial,
    this.userSearchList = const [],
  });

  final ApiStatus getUserSearchStatus;
  final List<dynamic> userSearchList;

  UserState copyWith({
    ApiStatus? getUserSearchStatus,
    // TODO: remove dynamic ans add proper types
    List<dynamic>? userSearchList,
  }) {
    return UserState(
      getUserSearchStatus: getUserSearchStatus ?? this.getUserSearchStatus,
      userSearchList: userSearchList ?? this.userSearchList,
    );
  }

  @override
  List<Object> get props => [getUserSearchStatus, userSearchList];
}
