import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talk_me/core/constant/app_exceptions.dart';
import 'package:talk_me/data/datasource/contract/local_datasource.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/data/network/safeCall.dart';
import 'package:talk_me/domain/mapper/app_exception_mapper.dart';

@Injectable(as: LocalDatasource)
class LocalDatasourceImpl implements LocalDatasource {
  LocalDatasourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<Results<void>> saveDataInSharedPreferences(
      BuildContext context,
    String key,
    dynamic value,
  ) async {
    return safeCall(() async {
      if (value is String ||
          value is int ||
          value is bool ||
          value is double ||
          value is List<String>) {
        if (value is String) {
          await _sharedPreferences.setString(key, value);
        } else if (value is int) {
          await _sharedPreferences.setInt(key, value);
        } else if (value is bool) {
          await _sharedPreferences.setBool(key, value);
        } else if (value is double) {
          await _sharedPreferences.setDouble(key, value);
        } else if (value is List<String>) {
          await _sharedPreferences.setStringList(key, value);
        }
        return Success();
      } else {
        return Failure(
          exception: SharedPreferencesException(),
          message: AppExceptionMapper.convertStringMessageToLocalizationStringMessage(SharedPreferencesException(), context),
        );
      }
    });
  }
}
