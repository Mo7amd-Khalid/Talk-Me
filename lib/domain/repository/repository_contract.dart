import 'package:flutter/material.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';

abstract class RepositoryContract {
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
  Future<Results<List<UserDm>>> getUsers(String uID);
}