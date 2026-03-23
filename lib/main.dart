import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_me/core/constant/app_constant.dart';
import 'package:talk_me/core/routes/app_route.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/core/theme/app_theme.dart';
import 'package:talk_me/presentation/setup_cubit/setup_contract.dart';
import 'package:talk_me/presentation/setup_cubit/setup_cubit.dart';

import 'core/di/di.dart';
import 'core/l10n/generated/app_localizations.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureDependencies();
  SharedPreferences sharedPreferences = getIt();
  String route = initialRoute(sharedPreferences);
  runApp(MyApp(route: route,));
}

class MyApp extends StatelessWidget {
  MyApp({required this.route, super.key});
  final String route;

  final SetupCubit setupCubit = getIt();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: setupCubit,
      child: BlocBuilder<SetupCubit, SetupState>(
        builder:(_,state) => MaterialApp(
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          themeMode: state.mode,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(state.language),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: route,
        ),
      ),
    );
  }
}

String initialRoute(SharedPreferences shared){
  if(shared.getBool(AppKeysConstant.onboardingKey)??false)
    {
      if((shared.getString(AppKeysConstant.loginKey)??"").isNotEmpty)
        {
          return Routes.mainViews;
        }
      return Routes.loginView;
    }
  return Routes.onboardingViews;
}