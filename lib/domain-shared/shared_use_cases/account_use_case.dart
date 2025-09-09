abstract class AccountUseCase {
  Future<void> updateFirebaseToken({
    required String oldAccount,
    String newAccount = "",
  }) async {}
}
