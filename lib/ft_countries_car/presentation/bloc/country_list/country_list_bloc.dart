import 'package:bloc/bloc.dart';

import '../../../domain/entities/country_summary.dart';
import '../../../domain/usecases/get_all_countries.dart';
import '../../../domain/usecases/search_countries.dart';
import 'country_list_event.dart';
import 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final GetAllCountries getAllCountries;
  final SearchCountries searchCountries;

  CountryListBloc({
    required this.getAllCountries,
    required this.searchCountries,
  }) : super(const CountryListState()) {
    on<LoadAllCountries>(_onLoadAllCountries);
    on<SearchCountriesEvent>(_onSearchCountries);
  }

  Future<void> _onLoadAllCountries(
    LoadAllCountries event,
    Emitter<CountryListState> emit,
  ) async {
    emit(state.copyWith(status: CountryListStatus.loading, message: ''));

    try {
      final List<CountrySummary> result = await getAllCountries();
      if (result.isEmpty) {
        emit(
          state.copyWith(
            status: CountryListStatus.empty,
            countries: const [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CountryListStatus.success,
            countries: result,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: CountryListStatus.error,
          message: 'Failed to load countries.',
        ),
      );
    }
  }

  Future<void> _onSearchCountries(
    SearchCountriesEvent event,
    Emitter<CountryListState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      // When query is cleared, reload all countries.
      add(const LoadAllCountries());
      return;
    }

    emit(state.copyWith(status: CountryListStatus.loading, message: ''));

    try {
      final List<CountrySummary> result = await searchCountries(query);
      if (result.isEmpty) {
        emit(
          state.copyWith(
            status: CountryListStatus.empty,
            countries: const [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CountryListStatus.success,
            countries: result,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: CountryListStatus.error,
          message: 'Failed to search countries.',
        ),
      );
    }
  }
}

