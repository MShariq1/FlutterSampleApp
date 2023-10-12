import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smaple_project/src/presentation/providers/authentication_provider.dart';
import 'package:smaple_project/src/presentation/providers/home_provider.dart';
import 'package:smaple_project/src/presentation/providers/locale_provider.dart';
import 'package:smaple_project/src/presentation/providers/main_view_provider.dart';
import 'package:smaple_project/src/source/core/client_api.dart';
import 'package:smaple_project/src/source/data_source/authentication_local_data_source.dart';
import 'package:smaple_project/src/source/data_source/authentication_remote_data_source.dart';
import 'package:smaple_project/src/source/data_source/remote_data_source.dart';
import 'package:smaple_project/src/source/repository/app_repository.dart';
import 'package:smaple_project/src/source/repository/authentication_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> setup() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final Dio dio = Dio();
  sl.registerLazySingleton<ApiClient>(
          () => ApiClient(dio: dio, authenticationLocalDataSource: sl()));
  sl.registerLazySingleton<IAuthenticationLocalDataSource>(() =>   AuthenticationLocalDataSource(sharedPreferences: sharedPreferences));
  sl.registerLazySingleton<IAuthenticationRemoteDataSource>(    () => AuthenticationRemoteDataSource(apiClient: sl()));
  sl.registerLazySingleton<IRemoteDataSource>(() =>  RemoteDataSource(apiClient: sl()));
  sl.registerLazySingleton<IAuthenticationRepository>(() =>  AuthenticationRepository( iAuthenticationRemoteDataSource: sl(), iAuthenticationLocalDataSource: sl()));
  sl.registerLazySingleton<IAppRepository>(() => AppRepository(remoteDataSource: sl()));
  ///providers
  sl.registerLazySingleton<MainViewProvider>(() => MainViewProvider());
  sl.registerLazySingleton<AuthenticationProvider>(() => AuthenticationProvider(iAuthenticationRepository: sl()));
  sl.registerLazySingleton<HomeProvider>(() => HomeProvider(iAppRepository: sl()));
  sl.registerLazySingleton<LocaleProvider>(() => LocaleProvider());


  dio.interceptors.addAll([
    prettyLogger(),
    //  AuthInterceptor(dio,sl()),
  ]);
}
