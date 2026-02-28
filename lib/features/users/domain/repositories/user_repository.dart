import 'package:flutter_github_api/core/api/api_result.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_details_entity.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_repo_entity.dart';

abstract class UserRepo {
  Future<ApiResult<List<UserListEntity>>> searchUsers({
    required String keyword,
  });
  Future<ApiResult<UserDetailsEntity>> getUserDetails({
    required String username,
  });
  Future<ApiResult<List<UserRepoEntity>>> getUserRepos({
    required String username,
  });
}
