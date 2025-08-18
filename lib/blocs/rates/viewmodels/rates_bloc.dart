import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:seeds/blocs/rates/mappers/rates_state_mapper.dart';
import 'package:seeds/blocs/rates/usecases/get_rates_use_case.dart';
import 'package:seeds/datasource/remote/model/fiat_rate_model.dart';
import 'package:seeds/datasource/remote/model/rate_model.dart';
import 'package:seeds/domain-shared/page_state.dart';

part 'rates_event.dart';
part 'rates_state.dart';

/* dev notes [Chuck 18 Aug]
  We want to have fiat values for many tokens
  Initially we supported SEEDS, Telos, and HUSD valuations
  Recently working on adding Rainbow Token valuations (thru Rainbow contract feature)
  We also want to be able to convert rates from one fiat currency to another
  Current code is ad hoc and combines these two functions
  -- update rate considerations --
  fiat-to-fiat foreign exchange rates are obtained from a free-tier commercial service
  We update no more than once per hour to limit usage
  Other valuations are expected to be slow-moving and are on the same update cycle

  Alternatively, each token valuation could be updated only when the token card is shown
*/
class RatesBloc extends Bloc<RatesEvent, RatesState> {
  DateTime lastUpdated = DateTime.now()
    .add(const Duration(seconds: 30)); // Hack to allow token whitelist to populate

  RatesBloc() : super(RatesState.initial()) {
    on<OnFetchRates>(_onFetchRates);
  }

  Future<void> _onFetchRates(OnFetchRates event, Emitter<RatesState> emit) async {
    print('Remaining minutes to fetch rates again: ${lastUpdated.difference(DateTime.now()).inMinutes}');
    if (DateTime.now().isAfter(lastUpdated)) {
      lastUpdated = lastUpdated.add(const Duration(hours: 1));
      final results = await GetRatesUseCase().run();
      emit(RatesStateMapper().mapResultToState(state, results));
    }
  }
}
