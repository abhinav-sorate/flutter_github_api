import 'package:flutter_github_api/core/api/api_endpoints.dart';
import 'package:flutter_github_api/core/api/client.dart';
import 'package:flutter_github_api/features/users/data/repositories/user_impl_repository.dart';
import 'package:flutter_github_api/features/users/domain/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repo_provider.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient(baseUrl: ApiEndpoints.baseUrl);
}

@Riverpod(keepAlive: true)
UserRepo userRepo(Ref ref) {
  return UserRepoImpl(client: ref.read(apiClientProvider));
}