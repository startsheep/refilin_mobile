import 'package:sp_util/sp_util.dart';

class LocalStorage {
  static const String _isUserLoggedInKey = 'is_user_logged_in';

  void init() async {
    await SpUtil.getInstance();
  }

  static set setUser(Map user) => SpUtil.putObject('user', user);
  static set setAuthToken(String token) => SpUtil.putString('token', token);
  static set setIsUserLoggedIn(bool hasLoggedIn) =>
      SpUtil.putBool('isAuthenticated', hasLoggedIn);

  static Map? getUser() {
    return SpUtil.getObject('user');
  }

  static get getAuthToken => SpUtil.getString('token')!;

  static get getIsUserLoggedIn => SpUtil.getBool('isAuthenticated')!;

  static void clear() {
    SpUtil.remove(_isUserLoggedInKey);
    SpUtil.clear();
    SpUtil.reload();
    // send log when data is cleared
  }
}
