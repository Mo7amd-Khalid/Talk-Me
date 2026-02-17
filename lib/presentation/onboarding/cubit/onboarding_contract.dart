import 'package:flutter/material.dart';

class OnboardingState {
  int currentIndex;
  OnboardingState({this.currentIndex = 0});

  OnboardingState copyWith({int? currentIndex})
  {
    return OnboardingState(currentIndex: currentIndex??this.currentIndex);
  }
}

sealed class OnboardingAction{}
class ChangeCurrentIndex extends OnboardingAction{
  int index;
  ChangeCurrentIndex({required this.index});
}
class GoToLoginScreen extends OnboardingAction{
  BuildContext context;
  GoToLoginScreen({required this.context});
}


sealed class OnBoardingNavigation{}
class NavigateToLoginScreen extends OnBoardingNavigation{}
class ShowErrorDialog extends OnBoardingNavigation{
  String message;
  ShowErrorDialog(this.message);
}