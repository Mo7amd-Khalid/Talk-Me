import 'package:cloud_firestore/cloud_firestore.dart';

class UserDm {
  String id;
  String name;
  String email;
  String image;
  List<String> friendsIds;
  List<String> additionRequest;

  UserDm({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.additionRequest,
    required this.friendsIds});


  factory UserDm.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data() ?? <String,dynamic> {};
    return UserDm(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      image: data['image'],
      additionRequest: ((data['additionRequest']??[]) as List<dynamic>).map((e) => e.toString()).toList(),
      friendsIds: ((data['friendsIds']??[]) as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
       "id": id,
       "name": name,
       "email": email,
       "image": image,
       "additionRequest": additionRequest,
       "friendsIds": friendsIds,
    };
  }
}