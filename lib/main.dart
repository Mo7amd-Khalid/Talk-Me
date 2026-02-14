import 'package:flutter/material.dart';
import 'package:talk_me/core/routes/app_route.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/core/theme/app_theme.dart';

import 'core/di/di.dart';
import 'core/l10n/generated/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.onboardingViews,
    );
  }
}
