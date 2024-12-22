import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/search/domain/usecase/search_city.dart';
import 'package:weather/features/search/presentation/bloc/search_city_state.dart';

class SearchCityCubit extends Cubit<SearchCityState> {
  SearchCityCubit() : super(InitialSearchCityState());

  Future<void> getSearchResultByName({required String query}) async {
    emit(SearchingCityState());
    final SearchCityByName byName = SearchCityByName();
    final List<String> result = await byName.getCityByName(cityName: query);
    emit(SearchCityStateResult(result));
  }
}
