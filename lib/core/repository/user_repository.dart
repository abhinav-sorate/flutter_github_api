import 'package:flutter_github_api/core/api/api_result.dart';

abstract class UserRepo {
  Future<ApiResult<dynamic>> searchUsers({required String keyword});
  Future<ApiResult<dynamic>> getUserDetails({required String username});
  Future<ApiResult<dynamic>> getUserRepos({required String username});
}
