import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:talk_me/core/routes/routes.dart';
import 'package:talk_me/presentation/login/login_view.dart';

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
