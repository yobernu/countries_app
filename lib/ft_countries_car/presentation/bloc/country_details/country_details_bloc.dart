import 'package:bloc/bloc.dart';

import '../../../domain/usecases/get_country_details.dart';
import 'country_details_event.dart';
import 'country_details_state.dart';

class CountryDetailsBloc
    extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  final GetCountryDetails getCountryDetails;

  CountryDetailsBloc(this.getCountryDetails)
      : super(const CountryDetailsState()) {
    on<LoadCountryDetails>(_onLoadCountryDetails);
  }

  Future<void> _onLoadCountryDetails(
    LoadCountryDetails event,
    Emitter<CountryDetailsState> emit,
  ) async {
    emit(state.copyWith(status: CountryDetailsStatus.loading, message: ''));

    try {
      final result = await getCountryDetails(event.cca2);
      emit(
        state.copyWith(
          status: CountryDetailsStatus.success,
          country: result,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CountryDetailsStatus.error,
          message: 'Failed to load country details.',
        ),
      );
    }
  }
}

