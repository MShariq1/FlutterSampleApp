import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smaple_project/src/source/models/countriesModel.dart';


import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/util/app_utility.dart';
import '../data_source/remote_data_source.dart';

typedef _Function<T> = Future<T> Function();

abstract class IAppRepository {
  final IRemoteDataSource remoteDataSource;
  const IAppRepository({required this.remoteDataSource});

  Future<Either<Failure, List<CountriesModel>>> getCountries();
}

class AppRepository extends IAppRepository {
  const AppRepository({required super.remoteDataSource});

  Future<Either<Failure, List<CountriesModel>>> getCountries() async {
    return await _callFunction<List<CountriesModel>>(
            () => remoteDataSource.getCountries());
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
