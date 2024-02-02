import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prostate_care/auth/login/login_screen.dart';
import 'package:prostate_care/auth/sign_up/sign_up.dart';
import 'package:prostate_care/firebase_options.dart';
import 'package:prostate_care/main_screens/main_screen.dart';
import 'package:prostate_care/models/reminder.dart';
import 'package:prostate_care/models/time_of_day_adapter.dart';
import 'package:prostate_care/models/user.dart';
import 'package:prostate_care/onboarding_screen/onboarding_screen.dart';
import 'package:prostate_care/providers/auth_provider.dart';
import 'package:prostate_care/providers/main_provider.dart';
import 'package:prostate_care/providers/notification_provider.dart';
import 'package:prostate_care/providers/reminder_provider.dart';
import 'package:prostate_care/settings/notification.dart';
import 'package:prostate_care/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ReminderAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox('userBox');
  await Hive.openBox('reminderBox');
  await Hive.openBox('riskBox');

  bool accepted = await NotificationFunction.requestPermissions();
  if (accepted) {
    NotificationFunction.init();
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prostate CARE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        MainScreen.id: (context) => const MainScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
      },
    );
  }
}
