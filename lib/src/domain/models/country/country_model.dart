import 'dart:convert';

class CountryModel {
  Name name;
  List<String> tld;
  String cca2;
  String ccn3;
  String cca3;
  bool independent;
  String status;
  bool unMember;
  Currencies currencies;
  Idd idd;
  List<String> capital;
  List<String> altSpellings;
  String region;
  Languages languages;
  Map<String, Translation> translations;
  List<double> latlng;
  bool landlocked;
  int area;
  Demonyms demonyms;
  String flag;
  Maps maps;
  int population;
  Car car;
  List<String> timezones;
  List<String> continents;
  Flags flags;
  CoatOfArms coatOfArms;
  String startOfWeek;
  CapitalInfo capitalInfo;

  CountryModel({
    required this.name,
    required this.tld,
    required this.cca2,
    required this.ccn3,
    required this.cca3,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.currencies,
    required this.idd,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.languages,
    required this.translations,
    required this.latlng,
    required this.landlocked,
    required this.area,
    required this.demonyms,
    required this.flag,
    required this.maps,
    required this.population,
    required this.car,
    required this.timezones,
    required this.continents,
    required this.flags,
    required this.coatOfArms,
    required this.startOfWeek,
    required this.capitalInfo,
  });

  static List<CountryModel> fromJsonList(List list) {
    return list.map((item) => CountryModel.fromJson(item)).toList();
  }

  factory CountryModel.fromRawJson(String str) => CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: Name.fromJson(json["name"]),
        tld: List<String>.from(json["tld"].map((x) => x)),
        cca2: json["cca2"],
        ccn3: json["ccn3"],
        cca3: json["cca3"],
        independent: json["independent"],
        status: json["status"],
        unMember: json["unMember"],
        currencies: Currencies.fromJson(json["currencies"]),
        idd: Idd.fromJson(json["idd"]),
        capital: List<String>.from(json["capital"].map((x) => x)),
        altSpellings: List<String>.from(json["altSpellings"].map((x) => x)),
        region: json["region"],
        languages: Languages.fromJson(json["languages"]),
        translations: Map.from(json["translations"])
            .map((k, v) => MapEntry<String, Translation>(k, Translation.fromJson(v))),
        latlng: List<double>.from(json["latlng"].map((x) => x?.toDouble())),
        landlocked: json["landlocked"],
        area: json["area"],
        demonyms: Demonyms.fromJson(json["demonyms"]),
        flag: json["flag"],
        maps: Maps.fromJson(json["maps"]),
        population: json["population"],
        car: Car.fromJson(json["car"]),
        timezones: List<String>.from(json["timezones"].map((x) => x)),
        continents: List<String>.from(json["continents"].map((x) => x)),
        flags: Flags.fromJson(json["flags"]),
        coatOfArms: CoatOfArms.fromJson(json["coatOfArms"]),
        startOfWeek: json["startOfWeek"],
        capitalInfo: CapitalInfo.fromJson(json["capitalInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "tld": List<dynamic>.from(tld.map((x) => x)),
        "cca2": cca2,
        "ccn3": ccn3,
        "cca3": cca3,
        "independent": independent,
        "status": status,
        "unMember": unMember,
        "currencies": currencies.toJson(),
        "idd": idd.toJson(),
        "capital": List<dynamic>.from(capital.map((x) => x)),
        "altSpellings": List<dynamic>.from(altSpellings.map((x) => x)),
        "region": region,
        "languages": languages.toJson(),
        "translations": Map.from(translations).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "latlng": List<dynamic>.from(latlng.map((x) => x)),
        "landlocked": landlocked,
        "area": area,
        "demonyms": demonyms.toJson(),
        "flag": flag,
        "maps": maps.toJson(),
        "population": population,
        "car": car.toJson(),
        "timezones": List<dynamic>.from(timezones.map((x) => x)),
        "continents": List<dynamic>.from(continents.map((x) => x)),
        "flags": flags.toJson(),
        "coatOfArms": coatOfArms.toJson(),
        "startOfWeek": startOfWeek,
        "capitalInfo": capitalInfo.toJson(),
      };
}

class CapitalInfo {
  List<double> latlng;

  CapitalInfo({
    required this.latlng,
  });

  factory CapitalInfo.fromRawJson(String str) => CapitalInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CapitalInfo.fromJson(Map<String, dynamic> json) => CapitalInfo(
        latlng: List<double>.from(json["latlng"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "latlng": List<dynamic>.from(latlng.map((x) => x)),
      };
}

class Car {
  List<String> signs;
  String side;

  Car({
    required this.signs,
    required this.side,
  });

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        signs: List<String>.from(json["signs"].map((x) => x)),
        side: json["side"],
      );

  Map<String, dynamic> toJson() => {
        "signs": List<dynamic>.from(signs.map((x) => x)),
        "side": side,
      };
}

class CoatOfArms {
  CoatOfArms();

  factory CoatOfArms.fromRawJson(String str) => CoatOfArms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoatOfArms.fromJson(Map<String, dynamic> json) => CoatOfArms();

  Map<String, dynamic> toJson() => {};
}

class Currencies {
  Shp shp;

  Currencies({
    required this.shp,
  });

  factory Currencies.fromRawJson(String str) => Currencies.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
        shp: Shp.fromJson(json["SHP"]),
      );

  Map<String, dynamic> toJson() => {
        "SHP": shp.toJson(),
      };
}

class Shp {
  String name;
  String symbol;

  Shp({
    required this.name,
    required this.symbol,
  });

  factory Shp.fromRawJson(String str) => Shp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shp.fromJson(Map<String, dynamic> json) => Shp(
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class Demonyms {
  Eng eng;

  Demonyms({
    required this.eng,
  });

  factory Demonyms.fromRawJson(String str) => Demonyms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Demonyms.fromJson(Map<String, dynamic> json) => Demonyms(
        eng: Eng.fromJson(json["eng"]),
      );

  Map<String, dynamic> toJson() => {
        "eng": eng.toJson(),
      };
}

class Eng {
  String f;
  String m;

  Eng({
    required this.f,
    required this.m,
  });

  factory Eng.fromRawJson(String str) => Eng.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Eng.fromJson(Map<String, dynamic> json) => Eng(
        f: json["f"],
        m: json["m"],
      );

  Map<String, dynamic> toJson() => {
        "f": f,
        "m": m,
      };
}

class Flags {
  String png;
  String svg;

  Flags({
    required this.png,
    required this.svg,
  });

  factory Flags.fromRawJson(String str) => Flags.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
      };
}

class Idd {
  String root;
  List<String> suffixes;

  Idd({
    required this.root,
    required this.suffixes,
  });

  factory Idd.fromRawJson(String str) => Idd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Idd.fromJson(Map<String, dynamic> json) => Idd(
        root: json["root"],
        suffixes: List<String>.from(json["suffixes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "root": root,
        "suffixes": List<dynamic>.from(suffixes.map((x) => x)),
      };
}

class Languages {
  String eng;

  Languages({
    required this.eng,
  });

  factory Languages.fromRawJson(String str) => Languages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        eng: json["eng"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
      };
}

class Maps {
  String googleMaps;
  String openStreetMaps;

  Maps({
    required this.googleMaps,
    required this.openStreetMaps,
  });

  factory Maps.fromRawJson(String str) => Maps.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        googleMaps: json["googleMaps"],
        openStreetMaps: json["openStreetMaps"],
      );

  Map<String, dynamic> toJson() => {
        "googleMaps": googleMaps,
        "openStreetMaps": openStreetMaps,
      };
}

class Name {
  String common;
  String official;
  NativeName nativeName;

  Name({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
        nativeName: NativeName.fromJson(json["nativeName"]),
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
        "nativeName": nativeName.toJson(),
      };
}

class NativeName {
  Translation eng;

  NativeName({
    required this.eng,
  });

  factory NativeName.fromRawJson(String str) => NativeName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NativeName.fromJson(Map<String, dynamic> json) => NativeName(
        eng: Translation.fromJson(json["eng"]),
      );

  Map<String, dynamic> toJson() => {
        "eng": eng.toJson(),
      };
}

class Translation {
  String official;
  String common;

  Translation({
    required this.official,
    required this.common,
  });

  factory Translation.fromRawJson(String str) => Translation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        official: json["official"],
        common: json["common"],
      );

  Map<String, dynamic> toJson() => {
        "official": official,
        "common": common,
      };
}
