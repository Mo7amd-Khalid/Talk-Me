import 'package:flutter/material.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';

abstract class FirestoreRemoteDatasource {

  Future<Results<void>> setUserData(UserDm user);
  Future<Results<List<UserDm>>> getUsers();
  Future<Results<UserDm>> getMyUserData(String uid);
  Future<Results<void>> removeUserData(String userId);
  Future<Results<bool>> checkIfUserExists(String email, BuildContext context);
  Future<Results<void>> sendAddRequest(String myID, String friendID);
  Future<Results<void>> removeAddRequest(String myID, String friendID);
  Future<Results<void>> acceptAddRequest(String myID, String friendID);

}