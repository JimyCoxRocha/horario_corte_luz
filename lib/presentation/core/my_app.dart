import 'package:flutter/material.dart';
import 'package:horario_corte_luz/presentation/page/home_page.dart';
import 'package:horario_corte_luz/presentation/page/onboarding_page.dart';
import 'package:horario_corte_luz/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserThemeNotifier>(
            create: (_) => UserThemeNotifier()..getUserThemePreference()),
      ],
      child: const AppContainer(),
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    UserThemeNotifier themeNotifier = context.watch<UserThemeNotifier>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horario Corte Luz',
      theme: ThemeData(
          useMaterial3: true,
          brightness:
              themeNotifier.isDarkModeOn ? Brightness.dark : Brightness.light),
      home: themeNotifier.isLogged ? const HomePage() : const OnboardingPage(),
    );
  }
}
