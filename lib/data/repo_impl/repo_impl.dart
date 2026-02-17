import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/data/datasource/contract/local_datasource.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';

@Injectable(as : RepositoryContract)
class RepoImpl implements RepositoryContract{
  RepoImpl(this._localDatasource);
  final LocalDatasource _localDatasource;

  @override
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, value) async{
    var response = await _localDatasource.saveDataInSharedPreferences(context, key, value);
    switch (response) {

      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

}