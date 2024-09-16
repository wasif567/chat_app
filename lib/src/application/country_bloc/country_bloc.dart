import 'package:chat/src/domain/models/country/country_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(const CountryInitial(countryList: [])) {
    on<GetCountryEvent>(_getCountryList);
  }

  Future _getCountryList(GetCountryEvent event, Emitter<CountryState> emit) async {
    try {
      List<CountryModel> countryList = [];
      emit(state.copyWith(
        cList: [],
        loading: true,
      ));
      Dio dio = Dio();
      final response = await dio.get("https://restcountries.com/v3.1/all");
      if (response.statusCode == 200) {
        countryList = CountryModel.fromJsonList(response.data);
        emit(state.copyWith(
          cList: countryList,
          loading: false,
        ));
      } else {
        emit(state.copyWith(cList: [], loading: false));
      }
    } catch (_) {
      emit(state.copyWith(cList: [], loading: false));
    }
  }
}
