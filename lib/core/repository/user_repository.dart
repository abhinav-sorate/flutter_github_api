import 'package:flutter_github_api/core/api/api_result.dart';
import 'package:flutter_github_api/features/users/data/models/user_list_model.dart';

abstract class UserRepo {
  Future<ApiResult<List<UserListModel>>> searchUsers({required String keyword});
  Future<ApiResult<dynamic>> getUserDetails({required String username});
  Future<ApiResult<dynamic>> getUserRepos({required String username});
}
