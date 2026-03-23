import 'package:flutter/material.dart';

class LoginState {
  bool obscurePassword;

  LoginState({this.obscurePassword = true});

  LoginState copyWith({bool? obscurePassword}) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

sealed class LoginActions {}
class ChangeObscurePassword extends LoginActions {}
class GoToRegisterScreen extends LoginActions {}
class GoToForgetPasswordScreen extends LoginActions {}
class LoginProcess extends LoginActions {
  BuildContext context;
  String email;
  String password;

  LoginProcess({required this.context, required this.email, required this.password});
}


sealed class LoginNavigation {}
class NavigateToRegisterScreen extends LoginNavigation {}
class NavigateToMainScreen extends LoginNavigation {
  String uid;
  NavigateToMainScreen({required this.uid});
}
class NavigateToForgetPasswordScreen extends LoginNavigation {}
class ShowLoadingDialog extends LoginNavigation {}
class ShowErrorDialog extends LoginNavigation {
  String message;
  ShowErrorDialog({required this.message});
}
