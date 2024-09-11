import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news/core/providers/home/home_provider.dart';
import 'package:news/core/providers/themes/themes_provider.dart';
import 'package:news/core/themes/app_themes.dart';
import 'package:news/modules/details/details_screen.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/modules/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/locales/locales_provider.dart';
import 'modules/home/home_screen.dart';

Future<void> main() async {
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await dotenv.load(fileName: "private_info.env");
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LocalesProvider(
        sharedPreferences: sharedPreferences,
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemesProvider(
        sharedPreferences: sharedPreferences,
      ),
    ),
    ChangeNotifierProvider(create: (context) => HomeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    LocalesProvider localesProvider = Provider.of(context);
    ThemesProvider themesProvider = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themesProvider.currentThemeMode,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SplashScreen.routName: (_) => const SplashScreen(),
        DetailsScreen.routeName: (_) => const DetailsScreen(),
        SearchScreen.routeName: (_) => SearchScreen()
      },
      initialRoute: SplashScreen.routName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localesProvider.currentLocale),
    );
  }
}
