import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/data/models/user_dm.dart';

class ChatState{
  Resources<List<UserDm>> friends;

  ChatState({this.friends = const Resources.initial()});

  ChatState copyWith({Resources<List<UserDm>>? friends}){
    return ChatState(friends: friends ?? this.friends);
  }
}

sealed class ChatActions{}
class GetFriends extends ChatActions{
  UserDm myData;
  GetFriends(this.myData);
}



sealed class ChatNavigation{}