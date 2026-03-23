import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDm {
  String senderId;
  String receiverId;
  int date;
  String message;
  String? image;

  MessageDm({
    required this.senderId,
    required this.receiverId,
    required this.date,
    required this.message,
    this.image,
});

  factory MessageDm.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data() ?? <String,dynamic> {};
    return MessageDm(
        senderId: data["senderId"],
        receiverId: data["receiverId"],
        date: data["date"],
        message: data["message"],
        image: data["image"] ?? ""
    );
  }

  Map<String , dynamic> toFirestore() {
    return{
      "senderId": senderId,
      "receiverId": receiverId,
      "date": date,
      "message": message,
      "image": image
    };
  }
}