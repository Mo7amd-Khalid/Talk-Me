import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/data/datasource/contract/firestore_remote_datasource.dart';
import 'package:talk_me/data/datasource/contract/local_datasource.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';

@Injectable(as : RepositoryContract)
class RepoImpl implements RepositoryContract{
  RepoImpl(this._localDatasource, this._firestoreRemoteDatasource);
  final LocalDatasource _localDatasource;
  final FirestoreRemoteDatasource _firestoreRemoteDatasource;

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

  @override
  Future<Results<List<UserDm>>> getUsers(String uID) async{
    var response = await _firestoreRemoteDatasource.getUsers();
    switch(response) {
      case Success<List<UserDm>>():
        {
          response.data!.removeWhere((user) => user.id == uID);
          return Success(data: response.data);
        }
      case Failure<List<UserDm>>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

}