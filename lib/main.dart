import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seeds/datasource/local/member_model_cache_item.dart';
import 'package:seeds/datasource/local/models/vote_model_adapter.dart';
import 'package:seeds/datasource/local/settings_storage.dart';
import 'package:seeds/datasource/remote/firebase/firebase_push_notification_service.dart';
import 'package:seeds/datasource/remote/firebase/firebase_remote_config.dart';
import 'package:seeds/datasource/remote/model/token_model.dart';
import 'package:seeds/domain-shared/bloc_observer.dart';
import 'package:seeds/seeds_app.dart';

Future<void> main() async {
  // Zone to handle asynchronous errors (Dart).
  // for details: https://docs.flutter.dev/testing/errors
  await runZonedGuarded(() async {
    final DateTime stamp1 = DateTime.now();
    WidgetsFlutterBinding.ensureInitialized();
    final DateTime stamp2 = DateTime.now();
    await dotenv.load(fileName: '.env');
    await Firebase.initializeApp();
    final DateTime stamp3 = DateTime.now();
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    final DateTime stamp4 = DateTime.now();
    await analytics.logEvent(
      name: 'app_initialized',
      parameters: {
        'stamp1': stamp1.toString(),
        'stamp2': stamp2.toString(),
        'stamp3': stamp3.toString(),
        'stamp4': stamp4.toString(),
        'item_id': 'LWupdate',
      },
    );
    await settingsStorage.initialise();
        await analytics.logEvent(
      name: 'settingsstore_initialized',
      parameters: {
        'action_type': 'startup',
        'item_id': 'LWupdate',
      },
    );
    await PushNotificationService().initialise();
    await analytics.logEvent(
      name: 'pushnotify_initialized',
      parameters: {
        'action_type': 'startup',
        'item_id': 'LWupdate',
      },
    );
    await remoteConfigurations.initialise();
    await analytics.logEvent(
      name: 'remoteconfig_initialized',
      parameters: {
        'action_type': 'startup',
        'item_id': 'LWupdate',
      },
    );
    await TokenModel.installModels(['localscale','lightwallet','experimental'], [TokenModel.seedsEcosysUsecase]);
    await analytics.logEvent(
      name: 'tokenmodels_installed',
      parameters: {
        'action_type': 'startup',
        'item_id': 'LWupdate',
      },
    );
    await Hive.initFlutter();
    Hive.registerAdapter(MemberModelCacheItemAdapter());
    Hive.registerAdapter(VoteModelAdapter());
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // Called whenever the Flutter framework catches an error.
    FlutterError.onError = (details) async {
      FlutterError.presentError(details);
      // TODO(Raul): use FirebaseCrashlytics or whatever
      //await FirebaseCrashlytics.instance.recordFlutterError(details);
    };

    if (kDebugMode) {
      /// Bloc logs only in debug (for better performance in release)
      Bloc.observer = DebugBlocObserver();
    } 
    runApp(const SeedsApp());
  }, (error, stackTrace) async {
    //await FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
