class CountriesModel {
  final Flags flags;
  final CountryName name;

  CountriesModel({
    required this.flags,
    required this.name
  });

  factory CountriesModel.fromJson(Map<String, dynamic> map) {
    return CountriesModel(
      flags: Flags.fromJson(map['flags']),
      name: CountryName.fromJson(map['name']),
    );
  }
}

class Flags {
  final String png;

  Flags({
    required this.png
});

  factory Flags.fromJson(Map<String, dynamic> map) {
    return Flags(
      png: map['png']??"",
    );
  }
}

class CountryName {
  final String official;

  CountryName({required this.official});


  factory CountryName.fromJson(Map<String, dynamic> map) {
    return CountryName(
      official: map['official']??"",
    );
  }
}
