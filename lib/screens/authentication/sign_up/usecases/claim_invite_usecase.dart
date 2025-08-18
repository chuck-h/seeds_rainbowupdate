import 'package:async/async.dart';
import 'package:seeds/datasource/remote/api/invite_repository.dart';
import 'package:seeds/datasource/remote/api/signup_repository.dart';
import 'package:seeds/utils/mnemonic_code/mnemonic_code.dart';

class ClaimInviteUseCase {
  Future<Result> validateInviteCode(String inviteCode) {
    final String inviteSecret = secretFromMnemonic(inviteCode);
    final String inviteHash = hashFromSecret(inviteSecret);
    return InviteRepository().findInvite(inviteHash);
  }

  Future<Result> unpackLink(String link) {
    const String prefix = 'seedsinvite-';
    if(link.startsWith(prefix)) {
      return Future<Result>(() => Result.value(link.substring(prefix.length)));
    } else {
      // Dynamic Links end of life Aug 25 2025
      return SignupRepository().unpackDynamicLink(link);
    }
  }
}
