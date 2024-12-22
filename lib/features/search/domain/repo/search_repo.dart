abstract class SearchCityRepo {
  Future<List<String>> getCityByName({required String cityName});
}
