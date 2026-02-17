import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/auth_repository.dart';
import 'package:talk_me/presentation/forget_password/cubit/forget_password_contract.dart';

@injectable
class ForgetPasswordCubit extends BaseCubit<ForgetPasswordState, ForgetPasswordAction , ForgetPasswordNavigation>{
  ForgetPasswordCubit(this._authRepository) : super(ForgetPasswordState());

  final AuthRepository _authRepository;

  @override
  Future<void> doAction(ForgetPasswordAction action) async{
    switch(action) {
      case SendForgetPasswordEmail():
        _sendForgetPasswordEmail(action.email, action.context);
      case GoToLoginScreen():
        _goToLoginScreen();
    }
  }

  void _sendForgetPasswordEmail(String email, BuildContext context) async{
    emitNavigation(ShowLoadingDialog());
    var response = await _authRepository.sendResetPasswordEmail(email, context);
    switch(response) {
      case Success<void>():
        emitNavigation(ShowSuccessDialog());
      case Failure<void>():
        emitNavigation(ShowErrorDialog(response.message!));
    }
  }

  void _goToLoginScreen() {
    emitNavigation(NavigateToLoginScreen());
  }

}