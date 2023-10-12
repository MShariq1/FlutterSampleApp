import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/enum/body_type.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/util/app_utility.dart';
import '../data_source/authentication_local_data_source.dart';
import '../data_source/authentication_remote_data_source.dart';
import '../models/login_model.dart';

typedef _Function<T> = Future<T> Function();

abstract class IAuthenticationRepository {
  final IAuthenticationRemoteDataSource iAuthenticationRemoteDataSource;
  final IAuthenticationLocalDataSource iAuthenticationLocalDataSource;

  IAuthenticationRepository(
      {required this.iAuthenticationRemoteDataSource,
      required this.iAuthenticationLocalDataSource});

  Future<Either<Failure, Login>> loginWithEmailAndPassword(
      {required String emailAddress,
        required String password,
        required String deviceToken,
        required DeviceType deviceType});
  Future<Either<Failure,Authentication>> logout();
  Either<Failure, Authentication> checkUserLoggedInStatus();
}

class AuthenticationRepository extends IAuthenticationRepository {
  AuthenticationRepository(
      {required super.iAuthenticationRemoteDataSource,
      required super.iAuthenticationLocalDataSource});

  @override
  Future<Either<Failure, Login>> loginWithEmailAndPassword(
      {required String emailAddress,
        required String password,
        required String deviceToken,
        required DeviceType deviceType}) async {
    final value =  await _callFunction<Login>(() => iAuthenticationRemoteDataSource.loginWithEmailAndPassword(emailAddress: emailAddress, password: password,deviceToken: deviceToken, deviceType: deviceType));
    await value.fold((l) => null, (response)async {
      await iAuthenticationLocalDataSource.saveAccessToken(accessToken: response.accessToken, refreshToken: response.refreshToken);
    });
    return value;
  }

  @override
  Future<Either<Failure, Authentication>> logout()async {
    await iAuthenticationLocalDataSource.deleteAccessToken();
    return const Right(Authentication.unAuthenticated);

  }

  @override
  Either<Failure, Authentication> checkUserLoggedInStatus()  {
    try {
      final refreshToken = iAuthenticationLocalDataSource.getRefreshToken();
      final accessToken = iAuthenticationLocalDataSource.getAccessToken();
      if (refreshToken == null || accessToken == null) {
        return const Right(Authentication.unAuthenticated);
      }
      return const Right(Authentication.authenticated);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  Future<Either<Failure, T>> _callFunction<T>(_Function function) async {
    if (true) {
      try {
        final remoteTrivia = await function();
        return Right(remoteTrivia);
      } on ServerException catch(e){
        String message = '';
        if(e.object is DioException){
          final exception = e.object as DioException;
          if(exception.response!.data.containsKey('error')){
            message =  exception.response!.data['error'];
          }
          if(exception.response!.data.containsKey('message')){
            message =  exception.response!.data['message'];
          }
          AppUtility.showToast(message: message);
        }
        return  Left(ServerFailure(message:message));
      }
    } else {
      try {
        // final localTrivia = await localDataSource.getLastNumberTrivia();
        // return Right(localTrivia);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }





}
