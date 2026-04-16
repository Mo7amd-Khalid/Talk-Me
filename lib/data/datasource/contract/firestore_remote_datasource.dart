import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talk_me/data/models/message_dm.dart';
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
  Results<Stream<QuerySnapshot<MessageDm>>> getMessages(String chatId);
  Future<Results<void>> sendMessage(MessageDm message, String chatId);
  Future<Results<void>> refreshFCMToken(String uid, String newFCToken);

}