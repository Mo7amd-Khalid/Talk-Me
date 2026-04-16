import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDm {
  String id;
  String senderId;
  String receiverId;
  String timeOfMessage;
  int milliSecondTime;
  String message;
  String? image;

  MessageDm({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.timeOfMessage,
    required this.milliSecondTime,
    required this.message,
    this.image,
});

  factory MessageDm.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data() ?? <String,dynamic> {};
    return MessageDm(
        id: data["id"],
        senderId: data["senderId"],
        receiverId: data["receiverId"],
        timeOfMessage: data["timeOfMessage"],
        milliSecondTime: data["milliSecondTime"],
        message: data["message"],
        image: data["image"] ?? ""
    );
  }

  Map<String , dynamic> toFirestore() {
    return{
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "timeOfMessage": timeOfMessage,
      "milliSecondTime": milliSecondTime,
      "message": message,
      "image": image
    };
  }
}