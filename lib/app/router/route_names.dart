class Routes {
  static const home = '/';

  static const userDetails = '/user-details/:username';
  static String userDetailsPath(String username) => '/user-details/$username';
}
