import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:seeds/datasource/remote/model/firebase_eos_servers.dart';

const String _activeEOSEndpointKey = 'eos_endpoints';
const String _hyphaEndPointKey = 'hypha_end_point';
const String _defaultEndPointUrlKey = 'default_end_point';
const String _defaultV2EndPointUrlKey = 'default_v2_end_point';
const String _featureFlagImportAccount = 'feature_flag_import_account';
const String _featureFlagExportRecoveryPhrase = 'feature_flag_export_recovery_phrase';
const String _featureFlagDelegate = 'feature_flag_delegate';
const String _featureFlagClaimUnplantedSeeds = 'feature_flag_unplant_claim_seeds';
const String _featureFlagP2P = 'feature_flag_p2p';
const String _featureFlagRegions = 'feature_flag_regions_enabled';
const String _featureFlagTokenMasterList = 'feature_flag_token_master_list_enabled';
const String _featureFlagNonMemberUse = 'feature_flag_non_member_use_enabled';

// MAINNET CONFIG
const String _eosEndpoints = '[ { "url": "https://mainnet.telos.net", "isDefault": true } ]';
const String _hyphaEndPointUrl = 'https://node.hypha.earth';
const String _defaultEndPointUrl = "https://mainnet.telos.net";
// we need a separate endpoint for v2/history as most nodes don't support v2
const String _defaultV2EndpointUrl = "https://mainnet.telos.net";

// DO NOT PUSH TO PROD WITH THIS SET TO TRUE. This is used for testing purposes only
const bool testnetMode = false;
const bool unitTestMode = false; // set testnetMode and unitTestMode to true for automated tests

// TESTNET CONFIG: Used for testing purposes.
const String _testnetEosEndpoints = '[ { "url": "https://api-test.telosfoundation.io", "isDefault": true } ]';
const String _testnetHyphaEndPointUrl = 'https://api-test.telosfoundation.io';
const String _testnetDefaultEndPointUrl = "https://api-test.telosfoundation.io";
const String _testnetDefaultV2EndpointUrl = "https://api-test.telosfoundation.io";
// END - TESTNET CONFIG

// UNIT TEST CONFIG: Used for automated testing
const String _unitTestEosEndpoints = '[ { "url": "https://node.hypha.earth", "isDefault": true } ]';
const String _unitTestHyphaEndPointUrl = 'https://node.hypha.earth';
const String _unitTestDefaultEndPointUrl = "https://node.hypha.earth";
const String _unitTestDefaultV2EndpointUrl = "https://mainnet.telos.net";
// END - UNIT TEST CONFIG

class _FirebaseRemoteConfigService {
  late FirebaseRemoteConfig _remoteConfig;

  factory _FirebaseRemoteConfigService() => _instance;

  _FirebaseRemoteConfigService._();

  static final _FirebaseRemoteConfigService _instance = _FirebaseRemoteConfigService._();

  final defaults = <String, dynamic>{
    _featureFlagImportAccount: false,
    _featureFlagExportRecoveryPhrase: false,
    _featureFlagDelegate: false,
    _featureFlagClaimUnplantedSeeds: false,
    _featureFlagP2P: false,
    _featureFlagRegions: false,
    _featureFlagTokenMasterList: true,
    _featureFlagNonMemberUse: false,
    _activeEOSEndpointKey: _eosEndpoints,
    _hyphaEndPointKey: _hyphaEndPointUrl,
    _defaultEndPointUrlKey: _defaultEndPointUrl,
    _defaultV2EndPointUrlKey: _defaultV2EndpointUrl
  };

  Future refresh() async {
    try {
      await _remoteConfig.fetch();
      print(" _remoteConfig fetch worked");
      try {
        final value = await _remoteConfig.activate();
        print(" _remoteConfig activate worked params were activated $value");
      } catch (e) {
        print(" _remoteConfig activate failed $e");
      }
    } catch (e) {
      print(" _remoteConfig fetch failed $e");
    }
  }

  Future initialise() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.setDefaults(defaults);

    /// Maximum age of a cached config before it is considered stale. we set to 60 secs since we store important data.
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      minimumFetchInterval: const Duration(seconds: 60),
      fetchTimeout: const Duration(seconds: 5),
    ));

    await refresh();
  }

  bool get featureFlagImportAccountEnabled => _remoteConfig.getBool(_featureFlagImportAccount);
  bool get featureFlagExportRecoveryPhraseEnabled => _remoteConfig.getBool(_featureFlagExportRecoveryPhrase);
  bool get featureFlagDelegateEnabled => _remoteConfig.getBool(_featureFlagDelegate);
  bool get featureFlagClaimUnplantedSeedsEnabled => _remoteConfig.getBool(_featureFlagClaimUnplantedSeeds);
  bool get featureFlagP2PEnabled => _remoteConfig.getBool(_featureFlagP2P);
  bool get featureFlagRegionsEnabled => _remoteConfig.getBool(_featureFlagRegions);
  bool get featureFlagTokenMasterListEnabled => _remoteConfig.getBool(_featureFlagTokenMasterList);
  bool get featureFlagNonMeberUseEnabledEnabled => _remoteConfig.getBool(_featureFlagNonMemberUse);

  String get hyphaEndPoint => testnetMode
      ? unitTestMode
          ? _unitTestHyphaEndPointUrl
          : _testnetHyphaEndPointUrl
      : _remoteConfig.getString(_hyphaEndPointKey);

  String get defaultEndPointUrl => testnetMode
      ? unitTestMode
          ? _unitTestDefaultEndPointUrl
          : _testnetDefaultEndPointUrl
      : _remoteConfig.getString(_defaultEndPointUrlKey);

  String get defaultV2EndPointUrl => testnetMode
      ? unitTestMode
          ? _unitTestDefaultV2EndpointUrl
          : _testnetDefaultV2EndpointUrl
      : _remoteConfig.getString(_defaultV2EndPointUrlKey);

  FirebaseEosServer get activeEOSServerUrl => parseEosServers(testnetMode
          ? unitTestMode
              ? _unitTestEosEndpoints
              : _testnetEosEndpoints
          : _remoteConfig.getString(_activeEOSEndpointKey))
      .firstWhere((FirebaseEosServer element) => element.isDefault!,
          orElse: () => parseEosServers(_remoteConfig.getString(_activeEOSEndpointKey)).first);
}

// A function that converts a response body into a List<FirebaseEosServer>.
List<FirebaseEosServer> parseEosServers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return List<FirebaseEosServer>.of(parsed.map<FirebaseEosServer>((json) => FirebaseEosServer.fromJson(json as Map<String, dynamic>))
     as Iterable<FirebaseEosServer>);
}

/// Singleton
_FirebaseRemoteConfigService remoteConfigurations = _FirebaseRemoteConfigService();
