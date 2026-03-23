import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/constant/app_constant.dart';
import 'package:talk_me/data/models/message_dm.dart';
import 'package:talk_me/data/models/user_dm.dart';

@module
abstract class ProvideFirebase {
  @lazySingleton
  FirebaseAuth firebaseAuth() => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore firebaseFirestore() => FirebaseFirestore.instance;

  @lazySingleton
  CollectionReference<UserDm> userFirestore() => FirebaseFirestore.instance
      .collection(AppKeysConstant.usersCollectionKey)
      .withConverter(
        fromFirestore: UserDm.fromFirestore,
        toFirestore: (UserDm user, option) => user.toFirestore(),
      );

  @lazySingleton
  CollectionReference<MessageDm> chatFirestore(String chatId) =>
      FirebaseFirestore.instance
          .collection(AppKeysConstant.usersCollectionKey)
          .doc(chatId)
          .collection("chats")
          .withConverter(
            fromFirestore: MessageDm.fromFirestore,
            toFirestore: (MessageDm message, option) => message.toFirestore(),
          );
}
