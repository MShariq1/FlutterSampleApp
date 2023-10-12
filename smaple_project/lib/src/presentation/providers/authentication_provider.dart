import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:smaple_project/src/source/repository/authentication_repository.dart';

import '../../../dependency_injector.dart';
import '../../core/enum/body_type.dart';
import '../../core/enum/bottom_navigation.dart';
import '../../core/error/failures.dart';
import '../../source/models/login_model.dart';
import 'main_view_provider.dart';

class AuthenticationProvider with ChangeNotifier {
  final IAuthenticationRepository iAuthenticationRepository;

  AuthenticationProvider({required this.iAuthenticationRepository});

  late Either<Failure, Login> _login;
  Either<Failure, Login> get login => _login;

  set login(Either<Failure, Login> value) {
    _login = value;
    notifyListeners();
  }

  NotifierState _loginState = NotifierState.none;
  NotifierState get state => _loginState;

  void _setLoginState(NotifierState state) {
    _loginState = state;
    notifyListeners();
  }

  bool get isUserAuthenticated {
    return iAuthenticationRepository.checkUserLoggedInStatus().fold(
        (failure) => false,
        (authentication) => authentication == Authentication.authenticated);
  }

  Future<void> loginWithEmailAndPassword(
      {required String emailAddress,
      required String password,
      required String deviceToken,
      required DeviceType deviceType}) async {
    _setLoginState(NotifierState.loaded);
    final value = await iAuthenticationRepository.loginWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
        deviceToken: deviceToken,
        deviceType: deviceType);
    login = value;
    _setLoginState(NotifierState.loaded);
  }

  Future<Either<Failure,Authentication>> logout()async{
    await Future.delayed(const Duration(seconds: 1));
    await iAuthenticationRepository.logout();
    final mainViewProvider = sl<MainViewProvider>();
    mainViewProvider.currentBottomNavigation=BottomNavigation.home;
    return iAuthenticationRepository.checkUserLoggedInStatus();
  }
}
