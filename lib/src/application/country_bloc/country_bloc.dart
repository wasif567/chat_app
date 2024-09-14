import 'package:chat/src/domain/country_repo/i_country_repo.dart';
import 'package:chat/src/domain/models/country/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final ICountryRepo _iCountryRepo;
  CountryBloc(this._iCountryRepo) : super(const CountryInitial(countryList: [])) {
    on<GetCountryEvent>(_getCountryList);
  }

  Future _getCountryList(GetCountryEvent event, Emitter<CountryState> emit) async {
    try {
      List<CountryModel> countrylist = await _iCountryRepo.getCountryList();
      if (countrylist.isNotEmpty) {
        emit(state.copyWith(cList: countrylist));
      } else {
        emit(state.copyWith(cList: []));
      }
    } catch (_) {}
  }
}
