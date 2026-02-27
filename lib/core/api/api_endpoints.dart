class ApiEndpoints {
  static const baseUrl = 'https://api.github.com/';
  static UserEndpoints user = UserEndpoints();
}

class UserEndpoints {
  String searchUsers({required String keyword}) => '/search/users?q=$keyword';
  String getUserDetails({required String username}) => '/users/$username';
  String getUserRepos({required String username}) => 'users/$username/repos';
}
