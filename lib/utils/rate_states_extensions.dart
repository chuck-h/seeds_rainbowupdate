import 'package:seeds/blocs/rates/viewmodels/rates_bloc.dart';
import 'package:seeds/datasource/local/models/fiat_data_model.dart';
import 'package:seeds/datasource/local/models/token_data_model.dart';
import 'package:seeds/datasource/remote/model/rate_model.dart';
import 'package:seeds/datasource/remote/model/token_model.dart';

extension RatesStateExtensions on RatesState {
  FiatDataModel? tokenToFiat(TokenDataModel tokenAmount, String currencySymbol) {
    final RateModel? rateModel = rates?[tokenAmount.id];
    if (rateModel != null && fiatRate != null) {
      final double? ratio = fiatRate!.currency2PerCurrency1(currencySymbol, rateModel.referenceFiat);
      if (ratio != null) {
        return FiatDataModel(rateModel!.fiatPerToken*ratio!*tokenAmount.amount, fiatSymbol: currencySymbol);
      }
    }
    return null;
  }

  TokenDataModel? fiatToToken(FiatDataModel fiatAmount, String tokenId) {
    final RateModel? rateModel = rates?[tokenId];
    if (rateModel != null && fiatRate != null && rateModel!.fiatPerToken > 0) {
      final double? ratio = fiatRate!.currency2PerCurrency1(fiatAmount.symbol, rateModel.referenceFiat);
      if (ratio != null) {
        return TokenDataModel(fiatAmount.amount*ratio!/rateModel!.fiatPerToken,
          token: TokenModel.fromId(tokenId)!);
      }
    }
    return null;
  }
}
