import 'package:flutter/material.dart';

class ForgetPasswordState {

}



sealed class ForgetPasswordAction {}
class SendForgetPasswordEmail extends ForgetPasswordAction{
  String email;
  BuildContext context;
  SendForgetPasswordEmail(this.email, this.context);
}
class GoToLoginScreen extends ForgetPasswordAction{}



sealed class ForgetPasswordNavigation {}
class ShowSuccessDialog extends ForgetPasswordNavigation{}
class ShowLoadingDialog extends ForgetPasswordNavigation{}
class ShowErrorDialog extends ForgetPasswordNavigation{
  String message;
  ShowErrorDialog(this.message);
}
class NavigateToLoginScreen extends ForgetPasswordNavigation{}