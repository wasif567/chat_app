part of 'country_bloc.dart';

@immutable
class CountryState {
  final List<CountryModel> countryList;
  const CountryState({required this.countryList});

  CountryState copyWith({required List<CountryModel> cList}) {
    return CountryState(countryList: cList);
  }
}

class CountryInitial extends CountryState {
  const CountryInitial({required super.countryList});
}
