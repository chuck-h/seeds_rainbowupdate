import 'package:async/async.dart';
import 'package:seeds/datasource/local/settings_storage.dart';
import 'package:seeds/datasource/remote/api/invite_repository.dart';
import 'package:seeds/domain-shared/app_constants.dart';
import 'package:seeds/utils/mnemonic_code/mnemonic_code.dart';

class CreateInviteUseCase {
  final InviteRepository _inviteRepository = InviteRepository();

  Future<List<Result>> run({required double amount, required String mnemonic}) {
    final String secret = secretFromMnemonic(mnemonic);
    final String hash = hashFromSecret(secret);

    final futures = [
      _inviteRepository.createInvite(
        quantity: amount,
        inviteHash: hash,
        accountName: settingsStorage.accountName,
      ),
      Future<Result>(() => Result.value(mnemonic))
    ];
    return Future.wait(futures);
  }
}
