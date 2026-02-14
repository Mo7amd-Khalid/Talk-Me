

import '../l10n/generated/app_localizations.dart';

class DataValidation{
  static String? nameValidation(String value, AppLocalizations locale){
    if (value.isEmpty) {
      return "name Required";
    } else if (!RegExp(r'^(?=.{3,}$)[A-Za-z\u0600-\u06FF ]+$').hasMatch(value)) {
      return "Invalid name";
    }
    return null;
  }

  static String? emailValidation(String value, AppLocalizations locale){
    if (value.isEmpty) {
      return "email Required";
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(value)) {
      return "Invalid email";
    }
    return null;
  }

  static String? passwordValidation(String value, AppLocalizations locale){
    if (value.isEmpty) {
      return "Password Required";
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$').hasMatch(value)) {
      return "Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character.";
    }
    return null;
  }

  static String? rePasswordValidation(String value,String password, AppLocalizations locale){
    if (value.isEmpty) {
      return "Password Required";
    } else if (value != password) {
      return "Password doesn`t match";
    }
    return null;
  }

  static String? titleEventValidator(String value, AppLocalizations locale)
  {
    if(value.isEmpty) return "Title is required";

    return null;
  }

  static String? descriptionEventValidator(String value, AppLocalizations locale)
  {
    if(value.isEmpty) return "Description is required";

    return null;
  }
}