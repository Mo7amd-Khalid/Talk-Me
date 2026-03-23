import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/domain/repository/auth_repository.dart';
import 'package:talk_me/presentation/bottom_nav_bar/settings/cubit/settings_contract.dart';

@injectable
class SettingsCubit extends BaseCubit<SettingsState, SettingsActions, SettingsNavigation>{
  SettingsCubit(this._authRepository) : super(SettingsState());

  final AuthRepository _authRepository;

  @override
  Future<void> doAction(SettingsActions action) async{
    switch (action) {
      case Logout():
        _logout(action.context);
      case LogoutConfirmation():
        _logoutConfirmation();
    }
  }

  void _logout(BuildContext context) async{
    await _authRepository.logout(context);
    emitNavigation(NavigateToLoginScreen());
  }

  void _logoutConfirmation() {
    emitNavigation(ShowAlertingDialog());
  }

}