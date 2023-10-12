

import 'package:smaple_project/src/source/models/countriesModel.dart';

import '../core/api_constant.dart';
import '../core/client_api.dart';

abstract class IRemoteDataSource {
  final ApiClient apiClient;

  const IRemoteDataSource({required this.apiClient});
  Future<List<CountriesModel>> getCountries();

}

class RemoteDataSource extends IRemoteDataSource {
  const RemoteDataSource({required super.apiClient});

  Future<List<CountriesModel>> getCountries() async {

      final response = await apiClient
          .get(Uri.parse('https://restcountries.com/v3.1/all?fields=name,flags'));
      print(response);
      return response.map<CountriesModel>((map) => CountriesModel.fromJson(map)).toList();
    }
  }



