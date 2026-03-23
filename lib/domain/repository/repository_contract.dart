import 'package:flutter/material.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';

abstract class RepositoryContract {
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
  Future<Results<List<UserDm>>> getUsers(UserDm myData);
  Future<Results<List<UserDm>>> getFriends(UserDm myData);
  Future<Results<UserDm>> getMyUserData(String uid);
  Future<Results<void>> sendAddRequest(String myID, String friendID);
  Future<Results<void>> removeAddRequest(String myID, String friendID);
  Future<Results<void>> acceptAddRequest(String myID, String friendID);
}