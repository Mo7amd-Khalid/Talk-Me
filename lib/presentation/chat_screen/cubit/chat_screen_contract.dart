import 'package:talk_me/data/models/message_dm.dart';

class ChatScreenState{}

sealed class ChatScreenAction{}
class SendMessage extends ChatScreenAction{
  MessageDm message;
  String chatId;
  SendMessage(this.message, this.chatId);
}

sealed class ChatScreenNavigation{}
