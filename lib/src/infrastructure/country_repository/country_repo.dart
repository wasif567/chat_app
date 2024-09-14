import 'dart:convert';

import 'package:chat/src/domain/country_repo/i_country_repo.dart';
import 'package:chat/src/domain/models/country/country_model.dart';
import 'package:chat/src/infrastructure/core/api_service.dart';

class CountryRepo extends ICountryRepo {
  final ApiService _apiService;

  CountryRepo(this._apiService);

  String url = "https://restcountries.com/v3.1/";

  @override
  Future getCountryList() async {
    try {
      _apiService.baseUrl = url;
      final response = await _apiService.get("all").timeout(const Duration(seconds: 60));
      if (response.statusCode == 200) {
        final decode = json.decode(response.data);
        return CountryModel.fromJsonList(decode);
      }
      return [];
    } catch (_) {
      rethrow;
    }
  }
}
