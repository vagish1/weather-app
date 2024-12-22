// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:weather/core/constants/app_constants.dart';
import 'package:weather/features/search/domain/repo/search_repo.dart';

class SearchCityByName extends SearchCityRepo {
  Timer? _debounce;
  SearchCityByName();
  @override
  Future<List<String>> getCityByName({required String cityName}) async {
    Completer<List<String>> completer = Completer<List<String>>();

    // Cancel the previous debounce timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set up a new debounce timer
    _debounce = Timer(Duration(milliseconds: 500), () {
      // Perform the search operation
      List<String> results = AppConstants.cityNames
          .where((city) => city.toLowerCase().contains(cityName.toLowerCase()))
          .toList();

      // Complete the Future with the results
      completer.complete(results);
    });

    // Return the Future, which will complete when the debounce timer finishes
    return completer.future;
  }
}
