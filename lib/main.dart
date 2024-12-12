import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_flutter_app/data_repo/db_helper.dart';
import 'package:recipe_flutter_app/ui/firebase_options.dart';
import 'package:recipe_flutter_app/ui/home_page/home_page.dart';
import 'package:recipe_flutter_app/ui/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/provider/recipe_provider.dart';
import 'package:recipe_flutter_app/ui/profile/profile_controller.dart';
import 'package:recipe_flutter_app/ui/widgets/splash_screen.dart';
import 'package:recipe_flutter_app/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DbHelper.dbHelper.initDatabase();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController =  Provider.of<ProfileController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: profileController.locale,
      home: const AuthWrapper(),
    );
  }
}

class AuthNotifier extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  AuthNotifier() {
    _initialize();
  }

  Future<void> _initialize() async {
    _isLoading = false;
    notifyListeners();
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthNotifier(),
      child: Consumer<AuthNotifier>(
        builder: (context, authNotifier, child) {
          if (authNotifier.isLoading) {
            return const SplashScreen();
          } else {
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else if (snapshot.hasData) {
                  return const HomePage();
                } else {
                  return const LoginPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
