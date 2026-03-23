import 'package:flutter/material.dart';

class SettingsState{}


sealed class SettingsActions{}
class Logout extends SettingsActions{
  BuildContext context;
  Logout(this.context);
}
class LogoutConfirmation extends SettingsActions{}


sealed class SettingsNavigation{}
class ShowAlertingDialog extends SettingsNavigation{}
class NavigateToLoginScreen extends SettingsNavigation{}