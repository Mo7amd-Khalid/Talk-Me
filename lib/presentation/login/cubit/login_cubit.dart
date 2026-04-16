import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/auth_repository.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';
import 'login_contract.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState, LoginActions, LoginNavigation>{
  LoginCubit(this._authRepository ,this._repo) :super(LoginState());

  final AuthRepository _authRepository;
  final RepositoryContract _repo;

  @override
  Future<void> doAction(LoginActions action) async{
    switch (action) {
      case ChangeObscurePassword():
        _changeObscurePassword();
      case GoToRegisterScreen():
        _goToRegisterScreen();
      case LoginProcess():
        _loginProcess(action.context, action.email, action.password);
      case GoToForgetPasswordScreen():
        _goToForgetPasswordScreen();
    }
  }

  void _changeObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _goToRegisterScreen() {
    emitNavigation(NavigateToRegisterScreen());
  }

  void _loginProcess(BuildContext context, String email, String password) async{
    emitNavigation(ShowLoadingDialog());
    var response = await _authRepository.login(context, email, password);
    switch(response) {
      case Success<UserCredential>():
        emitNavigation(NavigateToMainScreen(uid: response.data!.user!.uid));
        await _repo.refreshFCMToken(response.data!.user!.uid);
      case Failure<UserCredential>():
        emitNavigation(ShowErrorDialog(message: response.message!));
    }

  }

  void _goToForgetPasswordScreen() {
    emitNavigation(NavigateToForgetPasswordScreen());
  }


}