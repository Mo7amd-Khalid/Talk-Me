import 'package:flutter/material.dart';
import 'package:talk_me/data/network/results.dart';

abstract class RepositoryContract {
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
}