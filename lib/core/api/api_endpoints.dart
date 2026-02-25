class ApiEndpoints {
  static UserEndpoints user = UserEndpoints();
}

class UserEndpoints {
  final String getUser = '/user';
  String getUserRepos({required String username}) => 'users/$username/repos';
}
