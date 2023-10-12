
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api_constant.dart';

abstract class IAuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  const IAuthenticationLocalDataSource({required this.sharedPreferences});

  Future<void> saveAccessToken(
      {required String accessToken, required String refreshToken});

  String? getAccessToken();

  String? getRefreshToken();

  Future<void> deleteAccessToken();

}

class AuthenticationLocalDataSource extends IAuthenticationLocalDataSource {
  const AuthenticationLocalDataSource({required super.sharedPreferences});

  @override
  Future<void> deleteAccessToken() async {
    await sharedPreferences.remove(AppKeys.accessToken);
    await sharedPreferences.remove(AppKeys.refreshToken);
  }

  @override
  String? getAccessToken() {
    final token = sharedPreferences.getString(AppKeys.accessToken);
    return token;
  }

  @override
  Future<void> saveAccessToken(
      {required String accessToken, required String refreshToken}) async {
    await Future.wait([
      sharedPreferences.setString(AppKeys.accessToken, accessToken),
      sharedPreferences.setString(AppKeys.refreshToken, refreshToken),
    ]);
  }

  @override
  String? getRefreshToken() {
    final refreshToken = sharedPreferences.getString(AppKeys.refreshToken);
    return refreshToken;
  }


}
