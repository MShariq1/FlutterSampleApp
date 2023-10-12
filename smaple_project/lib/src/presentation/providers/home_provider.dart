import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:smaple_project/src/core/enum/body_type.dart';
import 'package:smaple_project/src/source/models/countriesModel.dart';
import 'package:smaple_project/src/source/repository/app_repository.dart';

import '../../core/error/failures.dart';

class HomeProvider with ChangeNotifier {

  final IAppRepository iAppRepository;
  HomeProvider({required this.iAppRepository}){
  }

   Either<Failure, List<CountriesModel>> _countriesData = Right([]);
  Either<Failure, List<CountriesModel>> get countriesData => _countriesData;
  set countriesData(Either<Failure, List<CountriesModel>> value) {
      _countriesData = value;
      notifyListeners();
  }

  NotifierState _countriesState = NotifierState.none;
  NotifierState get countriesState => _countriesState;
  void setCountriesState(NotifierState state) {
    _countriesState = state;
    notifyListeners();
  }

  Future<void> getCountries() async{
    print("========= tres");
    setCountriesState(NotifierState.loading);
    _countriesData = await iAppRepository.getCountries();
    setCountriesState(NotifierState.loaded);
  }

}