import 'package:flutter_github_api/core/api/api_result.dart';
import 'package:flutter_github_api/features/users/domain/entities/user_list_entity.dart';

abstract class UserRepo {
  Future<ApiResult<List<UserListEntity>>> searchUsers({
    required String keyword,
  });
  Future<ApiResult<dynamic>> getUserDetails({required String username});
  Future<ApiResult<dynamic>> getUserRepos({required String username});
}
