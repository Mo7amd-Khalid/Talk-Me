import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';

import 'onboarding_contract.dart';

@injectable
class OnboardingCubit extends BaseCubit<OnboardingState,OnboardingAction,OnBoardingNavigation>{
  OnboardingCubit():super(OnboardingState());

  @override
  Future<void> doAction(OnboardingAction action) async{
    switch (action) {

      case ChangeCurrentIndex():
        _changeCurrentIndex(action.index);
      case GoToLoginScreen():
        _goToLoginScreen();
    }
  }

  void _changeCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void _goToLoginScreen() {
    emitNavigation(NavigateToLoginScreen());
  }


}