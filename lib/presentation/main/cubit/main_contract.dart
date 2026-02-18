import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk_me/core/utils/resources.dart';

import '../../bottom_nav_bar/chats/chats_view.dart';
import '../../bottom_nav_bar/home/home_view.dart';
import '../../bottom_nav_bar/people/people_view.dart';
import '../../bottom_nav_bar/settings/settings_view.dart';

class MainState {
  Resources<User> currentUser;
  int currentIndex;
  List<Widget> pages = [HomeView(), PeopleView(), ChatsView(), SettingsView()];

  MainState({
    this.currentUser = const Resources.initial(),
    this.currentIndex = 0,
  });

  MainState copyWith({Resources<User>? currentUser, int? currentIndex}) {
    return MainState(
      currentUser: currentUser ?? this.currentUser,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

sealed class MainActions {}

class GetCurrentUserData extends MainActions {}

class ChangeCurrentIndex extends MainActions {
  int index;

  ChangeCurrentIndex(this.index);
}

sealed class MainNavigation {}
