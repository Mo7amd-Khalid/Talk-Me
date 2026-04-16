import 'package:flutter/material.dart';
import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/data/models/user_dm.dart';
import '../../bottom_nav_bar/chats/chats_view.dart';
import '../../bottom_nav_bar/home/home_view.dart';
import '../../bottom_nav_bar/settings/settings_view.dart';
import '../../bottom_nav_bar/users/users_view.dart';

class MainState {
  Resources<UserDm> currentUser;
  int currentIndex;
  List<Widget> pages = [HomeView(), UsersView(), ChatsView(), SettingsView()];

  MainState({
    this.currentUser = const Resources.initial(),
    this.currentIndex = 0,
  });

  MainState copyWith({Resources<UserDm>? currentUser, int? currentIndex}) {
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

class RefreshFCMToken extends MainActions {}


sealed class MainNavigation {}
