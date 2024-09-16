part of 'country_bloc.dart';

@immutable
class CountryState {
  final List<CountryModel>? countryList;
  final bool? isloading;
  const CountryState({this.countryList, this.isloading});

  CountryState copyWith({required List<CountryModel> cList, bool? loading = false}) {
    return CountryState(countryList: cList, isloading: loading ?? false);
  }
}

class CountryInitial extends CountryState {
  const CountryInitial({required super.countryList});
}
