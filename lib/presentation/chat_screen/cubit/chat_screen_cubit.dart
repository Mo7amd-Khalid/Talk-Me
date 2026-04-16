import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/core/base/base_cubit.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/domain/repository/repository_contract.dart';

import '../../../data/models/message_dm.dart';
import 'chat_screen_contract.dart';

@injectable
class ChatScreenCubit extends BaseCubit<ChatScreenState, ChatScreenAction, void>{
  ChatScreenCubit(this._repo) : super(ChatScreenState());

  final RepositoryContract _repo;

  @override
  Future<void> doAction(ChatScreenAction action) async{
    switch (action) {
      case SendMessage():
        _sendMessage(action.message, action.chatId);
    }
  }

  Stream<QuerySnapshot<MessageDm>> getMessages(String friendId) {
    var response = _repo.getMessages(friendId);
    return switch(response) {
      Success<Stream<QuerySnapshot<MessageDm>>>() => response.data!,
      // TODO: Handle this case.
      Failure<Stream<QuerySnapshot<MessageDm>>>() => throw UnimplementedError(),
    };
  }

  void _sendMessage(MessageDm message, String chatId) async{
    await _repo.sendMessage(message, chatId);

  }

}