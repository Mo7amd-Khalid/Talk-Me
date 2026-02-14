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
class GoToLoginScreen extends OnboardingAction{}


sealed class OnBoardingNavigation{}
class NavigateToLoginScreen extends OnBoardingNavigation{}