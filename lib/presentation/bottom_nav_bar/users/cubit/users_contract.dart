import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/data/models/user_dm.dart';

class UsersState {
  Resources<List<UserDm>> users;
  UsersState({this.users = const Resources.initial()});

  UsersState copyWith({Resources<List<UserDm>>? users,})
  {
    return UsersState(users: users ?? this.users);
  }

}

sealed class UsersActions{}
class GetUsers extends UsersActions{
  UserDm myData;
  GetUsers(this.myData);
}
class SendAddRequest extends UsersActions{
  String myID;
  String friendID;
  SendAddRequest(this.myID, this.friendID);
}
class RemoveAddRequest extends UsersActions{
  String myID;
  String friendID;
  RemoveAddRequest(this.myID, this.friendID);
}
class AcceptAddRequest extends UsersActions{
  UserDm myData;
  String friendID;
  AcceptAddRequest(this.myData, this.friendID);
}


sealed class UsersNavigation{}