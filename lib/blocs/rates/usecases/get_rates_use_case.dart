import 'dart:async';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:seeds/datasource/remote/api/rates_repository.dart';
import 'package:seeds/datasource/remote/model/rate_model.dart';

class GetRatesUseCase {
  final RatesRepository _ratesRepository = RatesRepository();

// Could refactor this... first 3 tasks are independent and can run concurrently
//  getRainbowRates repeatedly call the same api and need to run sequentially
//  run() must return a Future<List>
//  Chuck didn't know how to do all this cleanly
  Future<List<Result>> run() async {
    final List<Future<Result>> futures = [
      _ratesRepository.getSeedsRate(),
      _ratesRepository.getTelosRate(),
      _ratesRepository.getFiatRates(),
    ];
    final ratesFutures = (await Future.wait(futures)) + (await _ratesRepository.getRainbowRates());
    return Future(() => ratesFutures);
  }
}
