import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/presentation/forget_password/forget_password_view.dart';
import 'package:talk_me/presentation/login/login_view.dart';
import 'package:talk_me/presentation/main/main_view.dart';
import 'package:talk_me/presentation/register/register_view.dart';

import '../../presentation/onboarding/onboarding_view.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigating to: ${settings.name}');
    }

    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case Routes.onboardingViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OnboardingView(),
        );
      case Routes.loginView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginView(),
        );
      case Routes.registerView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegisterView(),
        );
      case Routes.forgetPasswordViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ForgetPasswordView(),
        );
      case Routes.mainViews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MainView(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Page Not Found')),
              ),
        );
    }
  }
}
