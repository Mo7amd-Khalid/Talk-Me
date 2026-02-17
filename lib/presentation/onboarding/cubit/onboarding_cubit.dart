import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/core/constant/app_constant.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';

import 'onboarding_contract.dart';

@injectable
class OnboardingCubit extends BaseCubit<OnboardingState,OnboardingAction,OnBoardingNavigation>{
  OnboardingCubit(this._repository):super(OnboardingState());
  
  final RepositoryContract _repository;

  @override
  Future<void> doAction(OnboardingAction action) async{
    switch (action) {

      case ChangeCurrentIndex():
        _changeCurrentIndex(action.index);
      case GoToLoginScreen():
        _goToLoginScreen(action.context);
    }
  }

  void _changeCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Future<void> _goToLoginScreen(BuildContext context) async{
    var repository = await _repository.saveDataInSharedPreferences(context, AppKeysConstant.onboardingKey, true);
    
    switch (repository) {
      
      case Success<void>():
        emitNavigation(NavigateToLoginScreen());
      case Failure<void>():
        emitNavigation(ShowErrorDialog(repository.message??""));
    }
    
  }


}