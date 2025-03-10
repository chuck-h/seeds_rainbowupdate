class FiatRateModel {
  Map<String?, num> rates;
  String? base;

  FiatRateModel(this.rates, {this.base = "USD"});

  factory FiatRateModel.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      final model = FiatRateModel(Map<String, num>.from(json["rates"] as Map), base: json["base"] as String);
      model.rebase("USD");
      return model;
    } else {
      return FiatRateModel({});
    }
  }

  double? currency2PerCurrency1(String currency1, String currency2) {
    if (rates[currency1] != null && rates[currency1]! > 0 
      && rates[currency2] != null && rates[currency2]! > 0) {
        return rates[currency1]!/rates[currency2]!;
      }
      return null;
  }

  void rebase(String symbol) {
    final rate = rates[symbol];
    if (rate != null) {
      rates[base] = 1.0;
      base = symbol;
      rates = rates.map((key, value) => MapEntry(key, value / rate));
      rates[base] = 1.0;
    } else {
      print("error - can't rebase to $symbol");
    }
  }
}
