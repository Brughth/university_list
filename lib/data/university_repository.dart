import 'package:dio/dio.dart';
import 'package:university_list/data/university_model.dart';

class UniversityRepository {
  final Dio dio = Dio();

  Future<List<UniversityModel>> getUniversitiesByCountryName(
      {required String countryName}) async {
    Response response = await dio
        .get('http://universities.hipolabs.com/search?country=$countryName');

    var data = response.data;
    var list = <UniversityModel>[];
    for (var json in data) {
      list.add(UniversityModel.fromJson(json));
    }
    return list;
  }
}
