import 'package:cloud_firestore/cloud_firestore.dart';

class UserDm {
  String id;
  String name;
  String email;
  String image;
  String fcm;
  List<String> friendsIds;
  List<String> sentRequest;
  List<String> receivedRequest;

  UserDm({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.sentRequest,
    required this.receivedRequest,
    required this.friendsIds,
    required this.fcm,
  });


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
      fcm: data['fcm'],
      sentRequest: ((data['sentRequest']??[]) as List<dynamic>).map((e) => e.toString()).toList(),
      receivedRequest: ((data['receivedRequest']??[]) as List<dynamic>).map((e) => e.toString()).toList(),
      friendsIds: ((data['friendsIds']??[]) as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
       "id": id,
       "name": name,
       "email": email,
       "image": image,
       "fcm": fcm,
       "sentRequest": sentRequest,
       "receivedRequest": receivedRequest,
       "friendsIds": friendsIds,
    };
  }
}