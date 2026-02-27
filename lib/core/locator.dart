import 'package:flutter_github_api/core/api/api_endpoints.dart';
import 'package:flutter_github_api/core/api/client.dart';
import 'package:flutter_github_api/core/bloc/user_bloc.dart';
import 'package:flutter_github_api/core/repository/user_impl_repository.dart';
import 'package:flutter_github_api/core/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(client: ApiClient(baseUrl: ApiEndpoints.baseUrl)),
  );

  locator.registerFactory<UserBloc>(() => UserBloc(locator<UserRepo>()));
}
