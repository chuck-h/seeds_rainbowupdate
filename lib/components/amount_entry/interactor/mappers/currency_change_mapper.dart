import 'package:seeds/components/amount_entry/interactor/mappers/amount_changer_mapper.dart';
import 'package:seeds/components/amount_entry/interactor/viewmodels/amount_entry_bloc.dart';
import 'package:seeds/components/amount_entry/interactor/viewmodels/page_commands.dart';
import 'package:seeds/domain-shared/result_to_state_mapper.dart';

class CurrencyChangeMapper extends StateMapper {
  AmountEntryState mapResultToState(AmountEntryState currentState) {
    final input = currentState.currentCurrencyInput == CurrencyInput.token ? CurrencyInput.fiat : CurrencyInput.token;
    String newText = "";
    if (input == CurrencyInput.fiat) {
      newText = currentState.fiatAmount?.asFixedString() ?? "";
    } else {
      newText = currentState.tokenAmount?.amountString() ?? "";
    }
    return currentState.copyWith(
      currentCurrencyInput: input,
      textInput: newText,
      pageCommand: PushTextIntoField(newText),
    );
  }
}
