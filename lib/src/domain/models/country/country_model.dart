import 'dart:convert';

class CountryModel {
  Name name;
  List<String> tld;
  bool independent;
  String status;
  bool unMember;
  Idd idd;
  List<String> capital;
  List<String> altSpellings;
  String region;
  Map<String, Translation> translations;
  List<double> latlng;
  bool landlocked;
  num area;
  String flag;
  Maps maps;
  num population;
  Car car;
  List<String> timezones;
  List<String> continents;
  Flags flags;
  CoatOfArms coatOfArms;
  String startOfWeek;

  CountryModel({
    required this.name,
    required this.tld,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.idd,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.translations,
    required this.latlng,
    required this.landlocked,
    required this.area,
    required this.flag,
    required this.maps,
    required this.population,
    required this.car,
    required this.timezones,
    required this.continents,
    required this.flags,
    required this.coatOfArms,
    required this.startOfWeek,
  });

  static List<CountryModel> fromJsonList(List list) {
    return list.map((item) => CountryModel.fromJson(item)).toList();
  }

  factory CountryModel.fromRawJson(String str) => CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: Name.fromJson(json["name"]),
        tld: json["tld"] != null ? List<String>.from(json["tld"].map((x) => x)) : [],
        independent: json["independent"] ?? false,
        status: json["status"],
        unMember: json["unMember"],
        idd: Idd.fromJson(json["idd"]),
        capital: json["capital"] != null ? List<String>.from(json["capital"].map((x) => x)) : [],
        altSpellings:
            json["altSpellings"] != null ? List<String>.from(json["altSpellings"].map((x) => x)) : [],
        region: json["region"],
        translations: Map.from(json["translations"])
            .map((k, v) => MapEntry<String, Translation>(k, Translation.fromJson(v))),
        latlng: List<double>.from(json["latlng"].map((x) => x?.toDouble())),
        landlocked: json["landlocked"],
        area: json["area"],
        flag: json["flag"],
        maps: Maps.fromJson(json["maps"]),
        population: json["population"],
        car: Car.fromJson(json["car"]),
        timezones: json["timezones"] != null ? List<String>.from(json["timezones"].map((x) => x)) : [],
        continents: json["continents"] != null ? List<String>.from(json["continents"].map((x) => x)) : [],
        flags: Flags.fromJson(json["flags"]),
        coatOfArms: CoatOfArms.fromJson(json["coatOfArms"]),
        startOfWeek: json["startOfWeek"],
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "tld": List<dynamic>.from(tld.map((x) => x)),
        "independent": independent,
        "status": status,
        "unMember": unMember,
        "idd": idd.toJson(),
        "capital": List<dynamic>.from(capital.map((x) => x)),
        "altSpellings": List<dynamic>.from(altSpellings.map((x) => x)),
        "region": region,
        "translations": Map.from(translations).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "latlng": List<dynamic>.from(latlng.map((x) => x)),
        "landlocked": landlocked,
        "area": area,
        "flag": flag,
        "maps": maps.toJson(),
        "population": population,
        "car": car.toJson(),
        "timezones": List<dynamic>.from(timezones.map((x) => x)),
        "continents": List<dynamic>.from(continents.map((x) => x)),
        "flags": flags.toJson(),
        "coatOfArms": coatOfArms.toJson(),
        "startOfWeek": startOfWeek,
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
        signs: json["signs"] != null ? List<String>.from(json["signs"].map((x) => x)) : [],
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
        root: json["root"] ?? "",
        suffixes: json["suffixes"] != null ? List<String>.from(json["suffixes"].map((x) => x)) : [],
      );

  Map<String, dynamic> toJson() => {
        "root": root,
        "suffixes": List<dynamic>.from(suffixes.map((x) => x)),
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

  Name({
    required this.common,
    required this.official,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
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
