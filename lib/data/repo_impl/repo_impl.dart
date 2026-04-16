import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/data/datasource/contract/fcm_remote_datasource.dart';
import 'package:talk_me/data/datasource/contract/firestore_remote_datasource.dart';
import 'package:talk_me/data/datasource/contract/local_datasource.dart';
import 'package:talk_me/data/models/message_dm.dart';
import 'package:talk_me/data/models/notification_dto.dart';
import 'package:talk_me/data/models/user_dm.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';

@Injectable(as : RepositoryContract)
class RepoImpl implements RepositoryContract{
  RepoImpl(this._localDatasource, this._firestoreRemoteDatasource, this.messaging, this._fcmRemoteDatasource);
  final LocalDatasource _localDatasource;
  final FirestoreRemoteDatasource _firestoreRemoteDatasource;
  final FirebaseMessaging messaging;
  final FCMRemoteDatasource _fcmRemoteDatasource;

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
  Future<Results<void>> sendAddRequest(UserDm myData, UserDm friendData) async{
    var response = await _firestoreRemoteDatasource.sendAddRequest(myData.id, friendData.id);
    switch (response) {
      case Success<void>():
        Message message = Message(
          token: friendData.fcm,
          notification: NotificationBody(
            title: "Friend Request",
            body: "${myData.name} sent you a friend request",
          ),
        );
        NotificationDto notification = NotificationDto(message: message);
        await sendNotification(notification);
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> removeAddRequest(UserDm myData, UserDm friendData) async{
    var response = await _firestoreRemoteDatasource.removeAddRequest(myData.id, friendData.id);
    switch (response) {
      case Success<void>():
        Message message = Message(
          token: friendData.fcm,
          notification: NotificationBody(
            title: "Friend Request",
            body: "${myData.name} cancel your friend request",
          ),
        );
        NotificationDto notification = NotificationDto(message: message);
        await sendNotification(notification);
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<void>> acceptAddRequest(UserDm myData, UserDm friendData) async{
    var response = await _firestoreRemoteDatasource.acceptAddRequest(myData.id, friendData.id);
    switch(response) {
      case Success<void>():
        Message message = Message(
          token: friendData.fcm,
          notification: NotificationBody(
            title: "Friend Request",
            body: "${myData.name} accept your friend request",
          ),
        );
        NotificationDto notification = NotificationDto(message: message);
        await sendNotification(notification);
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

  @override
  Results<Stream<QuerySnapshot<MessageDm>>> getMessages(String friendId) {
    var response = _firestoreRemoteDatasource.getMessages(friendId);
    switch (response) {

      case Success<Stream<QuerySnapshot<MessageDm>>>():
        return Success(data: response.data);
      case Failure<Stream<QuerySnapshot<MessageDm>>>():
        return Failure(exception: response.exception, message: response.message);
    }

  }

  @override
  Future<Results<void>> sendMessage(MessageDm message, String chatId) async{
    var response = await _firestoreRemoteDatasource.sendMessage(message, chatId);
    switch(response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure(exception: response.exception, message: response.message);
    }

  }

  @override
  Future<Results<void>> refreshFCMToken(String uid) async{
    var response = await _firestoreRemoteDatasource.getMyUserData(uid);

    switch(response) {
      case Success<UserDm>():
        String fcmToken = await messaging.getToken() ?? "";
        if(fcmToken != response.data!.fcm)
          {
            UserDm user = response.data!;
            user.fcm = fcmToken;
            var updateFCMToken = await _firestoreRemoteDatasource.setUserData(user);
            switch(updateFCMToken) {
              case Success<void>():return Success(message: "Token Updated");
              case Failure<void>():return Failure(exception: updateFCMToken.exception, message: updateFCMToken.message);
            }
          }
        else
          {
            return Success(message: "Token already exist");
          }
      case Failure<UserDm>():
        return Failure(exception: response.exception, message: response.message);
    }
  }

  @override
  Future<Results<bool>> sendNotification(NotificationDto notification) async{
    var response = await _fcmRemoteDatasource.sendNotification(notification);
    switch (response) {
      case Success<bool>():
        return Success(data: response.data);
      case Failure<bool>():
        return Failure(exception: response.exception, message: response.message);
    }

  }


}