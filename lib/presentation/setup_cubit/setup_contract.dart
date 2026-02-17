import 'package:flutter/material.dart';

class SetupState{
  String language;
  ThemeMode mode;

  SetupState({this.language = "en" , this.mode = ThemeMode.light});

  SetupState copyWith({String? language , ThemeMode? mode}){
    return SetupState(
      language: language ?? this.language,
      mode: mode ?? this.mode
    );
  }
}

sealed class SetupActions{}
class ChangeLanguage extends SetupActions{
  final String language;
  ChangeLanguage(this.language);
}
class ChangeMode extends SetupActions{
  final ThemeMode mode;
  ChangeMode(this.mode);
}
