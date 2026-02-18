import 'package:talk_me/core/utils/resources.dart';
import 'package:talk_me/data/models/user_dm.dart';

class PeopleState {
  Resources<List<UserDm>> users;
  PeopleState({this.users = const Resources.initial()});

  PeopleState copyWith({Resources<List<UserDm>>? users})
  {
    return PeopleState(users: users ?? this.users);
  }

}

sealed class PeopleActions{}
class GetUsers extends PeopleActions{
  String uID;
  GetUsers(this.uID);
}


sealed class PeopleNavigation{}