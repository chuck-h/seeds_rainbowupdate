import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:seeds/datasource/local/settings_storage.dart';
import 'package:seeds/datasource/remote/api/http_repo/http_repository.dart';
import 'package:seeds/datasource/remote/api/http_repo/seeds_scopes.dart';
import 'package:seeds/datasource/remote/api/http_repo/seeds_tables.dart';
import 'package:seeds/datasource/remote/model/fiat_rate_model.dart';
import 'package:seeds/datasource/remote/model/rate_model.dart';

class RatesRepository extends HttpRepository {
  Future<Result<FiatRateModel>> getFiatRates() {
    print("[http] get fiat rates");
    final about = "fiat rates from api-payment.hypha.earth api";
    return http
        .get(Uri.parse("https://api-payment.hypha.earth/fiatExchangeRates?api_key=$fxApiKey"))
        .then((http.Response response) => mapHttpResponse<FiatRateModel>(response, (Map<String, dynamic> body) {
              return FiatRateModel.fromJson(body);
            }))
        .catchError((error) => mapHttpError(error, about: about));
  }

  Future<Result<RateModel>> getSeedsRate() async {
    print('[http] get seeds rate USD');
    final about = "SEEDS rate from tlosto.seeds contract";

    final request = '{"json":true,"code":"tlosto.seeds","scope":"tlosto.seeds","table":"price"}';

    return http
        .post(Uri.parse('$baseURL/v1/chain/get_table_rows'), headers: headers, body: request)
        .then((http.Response response) => mapHttpResponse<RateModel>(response, (Map<String, dynamic> body) {
              return RateModel.fromSeedsJson(body);
            }))
        .catchError((error) => mapHttpError(error, about: about));
  }

  Future<Result<RateModel>> getTelosRate() async {
    print('[http] get telos rate USD');
    final about = "TLOS rate from ${SeedsCode.accountdelphioracle} constract";

    final params = createRequest(
      code: SeedsCode.accountdelphioracle,
      scope: "tlosusd",
      table: SeedsTable.tableDatapoints,
      // ignore: avoid_redundant_argument_values
      limit: 1,
    );

    return http
        .post(Uri.parse('$baseURL/v1/chain/get_table_rows'), headers: headers, body: params)
        .then((http.Response response) => mapHttpResponse<RateModel>(response, (Map<String, dynamic> body) {
              return RateModel.fromOracleJson("eosio.token#TLOS", 4, body);
            }))
        .catchError((error) => mapHttpError(error));
  }

  Future<Result<RateModel>> getRainbowRate(String tokenId) async {
    print('[http] get rainbow rate ${tokenId}');
    final about = "rate from rainbow contract";
    final contract = tokenId.split('#')[1];
    final symbol = tokenId.split('#')[2];
    final request = '{"json":true,"code":"${contract}","scope":"${symbol}","table":"configs"}';

    return http
        .post(Uri.parse('$baseURL/v1/chain/get_table_rows'), headers: headers, body: request)
        .then((http.Response response) => 
          mapHttpResponse<RateModel>(response, (Map<String, dynamic> body) {
              return RateModel.fromRainbowJson(tokenId, body);
          }))
        .catchError((error) => mapHttpError(error, about: about));
  }

  Future<List<Result>> getRainbowRates() async {
    // consider: try all tokens and silently ignore if they have no configs.val_per_token
    const rainbowContracts = ['rainbowproto', 'tokensmaster'];
    List<Result> rv = [];
    for (String tokenId in settingsStorage.tokensWhitelist) {
      final contract = tokenId.split('#')[1];
      if (rainbowContracts.contains(contract)) {
        rv.add(await getRainbowRate(tokenId));
      }
    };
    return Future(() => rv);
  }
}
