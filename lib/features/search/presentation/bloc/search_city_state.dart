abstract class SearchCityState {
  List<String> result;

  SearchCityState(this.result);
}

class InitialSearchCityState extends SearchCityState {
  InitialSearchCityState() : super([]);
}

class SearchingCityState extends SearchCityState {
  SearchingCityState() : super([]);
}

class SearchCityStateResult extends SearchCityState {
  SearchCityStateResult(super.result);
}
