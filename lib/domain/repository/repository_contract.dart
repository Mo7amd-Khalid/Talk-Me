import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talk_me/data/models/message_dm.dart';
import 'package:talk_me/data/models/notification_dto.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';

abstract class RepositoryContract {
  Future<Results<void>> saveDataInSharedPreferences(BuildContext context, String key, dynamic value);
  Future<Results<List<UserDm>>> getUsers(UserDm myData);
  Future<Results<List<UserDm>>> getFriends(UserDm myData);
  Future<Results<UserDm>> getMyUserData(String uid);
  Future<Results<void>> sendAddRequest(UserDm myData, UserDm friendData);
  Future<Results<void>> removeAddRequest(UserDm myData, UserDm friendData);
  Future<Results<void>> acceptAddRequest(UserDm myData, UserDm friendData);
  Results<Stream<QuerySnapshot<MessageDm>>> getMessages(String friendId);
  Future<Results<void>> sendMessage(MessageDm message, String chatId);
  Future<Results<void>> refreshFCMToken(String uid);
  Future<Results<bool>> sendNotification(NotificationDto notification);

}