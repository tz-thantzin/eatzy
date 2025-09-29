import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'eatzy_app.dart';
import 'firebase_options.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.setLanguageCode('en');
  await setupDependencies();

  //getIt<SharedPreferenceUseCase>().setOnboardingCompleted(false);
  runApp(EatzyApp());
}
