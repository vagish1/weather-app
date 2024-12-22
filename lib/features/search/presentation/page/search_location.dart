import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/search/presentation/bloc/search_city_cubit.dart';
import 'package:weather/features/search/presentation/bloc/search_city_state.dart';
import 'package:weather/features/weather/presentation/bloc/weather_card/weather_cubit.dart';

class SearchLocation extends StatefulWidget {
  final WeatherCubit weatherCubit;
  const SearchLocation({super.key, required this.weatherCubit});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  @override
  void initState() {
    searchCity.addListener(() {
      context
          .read<SearchCityCubit>()
          .getSearchResultByName(query: searchCity.text);
    });
    super.initState();
  }

  final TextEditingController searchCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {
            widget.weatherCubit.selectedCityName = searchCity.text.trim();
            widget.weatherCubit.fetchWeatherByCityName(searchCity.text.trim());
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 55),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text("Search Weather"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: TextField(
                controller: searchCity,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Search for location'),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchCityCubit, SearchCityState>(
                  builder: (_, state) {
                if (state is InitialSearchCityState) {
                  return Center(child: Text("Start Searching city by name"));
                }

                if (state is SearchingCityState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.result.isEmpty) {
                  return Center(
                    child: Text("No Result Found"),
                  );
                }

                return Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: ListView.separated(
                        itemBuilder: (_, index) {
                          String res = state.result.elementAt(index);
                          return ListTile(
                            onTap: () {
                              widget.weatherCubit.selectedCityName = res;
                              widget.weatherCubit.fetchWeatherByCityName(res);
                              Navigator.pop(context);
                            },
                            title: Text(res),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return Divider();
                        },
                        itemCount: state.result.length),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
