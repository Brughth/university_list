class UniversityModel {
  final String country;
  final String? alphaTwoCode;
  final String? stateProvince;
  final String name;
  final List<String>? webPages;
  final List<String>? domains;

  UniversityModel({
    required this.country,
    this.alphaTwoCode,
    this.stateProvince,
    required this.name,
    this.webPages,
    this.domains,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      country: json['country'],
      alphaTwoCode: json['alpha_two_code'],
      stateProvince: json['state-province'],
      name: json['name'],
      webPages: json['web_pages'] == null ? null : List.from(json['web_pages']),
      domains: json['domains'] == null ? null : List.from(json['domains']),
    );
  }
}
