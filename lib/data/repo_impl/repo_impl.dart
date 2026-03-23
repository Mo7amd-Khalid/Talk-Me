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
  Future<Results<List<UserDm>>> getUsers(UserDm myData) async{
    var response = await _firestoreRemoteDatasource.getUsers();
    switch(response) {
      case Success<List<UserDm>>():
        {
          response.data!.removeWhere((user) => user.id == myData.id || myData.friendsIds.contains(user.id));
          return Success(data: response.data);
        }
      case Failure<List<UserDm>>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> sendAddRequest(String myID, String friendID) async{
    var response = await _firestoreRemoteDatasource.sendAddRequest(myID, friendID);
    switch (response) {

      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> removeAddRequest(String myID, String friendID) async{
    var response = await _firestoreRemoteDatasource.removeAddRequest(myID, friendID);
    switch (response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<UserDm>> getMyUserData(String uid) async{
    var response = await _firestoreRemoteDatasource.getMyUserData(uid);
    switch(response) {
      case Success<UserDm>():
        return Success(data: response.data);
      case Failure<UserDm>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> acceptAddRequest(String myID, String friendID) async{
    var response = await _firestoreRemoteDatasource.acceptAddRequest(myID, friendID);
    switch(response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }

  }

  @override
  Future<Results<List<UserDm>>> getFriends(UserDm myData) async{
    var response = await _firestoreRemoteDatasource.getUsers();
    switch(response) {
      case Success<List<UserDm>>():
        {
          List<UserDm> friends = response.data!.where((user) => myData.friendsIds.contains(user.id)).toList();
          return Success(data: friends);
        }
      case Failure<List<UserDm>>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

}