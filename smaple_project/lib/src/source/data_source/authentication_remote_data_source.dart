import '../../core/enum/body_type.dart';
import '../core/api_constant.dart';
import '../core/client_api.dart';
import '../models/login_model.dart';

abstract class IAuthenticationRemoteDataSource {
  final ApiClient apiClient;

  IAuthenticationRemoteDataSource({required this.apiClient});

  Future<Login> loginWithEmailAndPassword(
      {required String emailAddress,
      required String password,
      required deviceToken,
      required DeviceType deviceType});
}

abstract class SignInMethod<T> {
  Future<T> signInWithEmailAndPassword();

  Future<T> signInWithFacebook();

  Future<T> signInWithGoogle();

  Future<T> signInWithApple();
}

class AuthenticationRemoteDataSource extends IAuthenticationRemoteDataSource {
  AuthenticationRemoteDataSource({required super.apiClient});

  @override
  Future<Login> loginWithEmailAndPassword(
      {required String emailAddress,
      required String password,
      required deviceToken,
      required DeviceType deviceType}) async {
    final response = await apiClient.post(
      Uri.http(ApiConstant.baseUrl, ApiConstant.loginWithEmailAndPassword),
      body: {
        "email": emailAddress,
        "password": password,
        "device_token": deviceToken,
        "device_type": deviceType.name
      },
    );
    return Login.fromJson(response);
  }
}
