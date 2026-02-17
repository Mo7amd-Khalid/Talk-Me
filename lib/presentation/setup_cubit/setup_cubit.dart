import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/presentation/setup_cubit/setup_contract.dart';

@singleton
class SetupCubit extends BaseCubit<SetupState, SetupActions, void>{
  SetupCubit() : super(SetupState());

  @override
  Future<void> doAction(SetupActions action) async {
    switch (action) {

      case ChangeLanguage():
        _changeLanguage(action.language);
      case ChangeMode():
        _changeMode(action.mode);
    }
  }

  void _changeLanguage(String language) {
    emit(state.copyWith(language: language));
  }

  void _changeMode(ThemeMode mode) {
    emit(state.copyWith(mode: mode));
  }

}