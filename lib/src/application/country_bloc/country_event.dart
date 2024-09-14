part of 'country_bloc.dart';

@immutable
sealed class CountryEvent {}

class GetCountryEvent extends CountryEvent {}
