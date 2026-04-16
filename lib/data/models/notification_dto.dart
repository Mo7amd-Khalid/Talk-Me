class NotificationDto {
  final Message message;

  NotificationDto({required this.message});

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      message: Message.fromJson(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message.toJson(),
    };
  }
}

class Message {
  final String token;
  final NotificationBody notification;

  Message({
    required this.token,
    required this.notification,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      token: json['token'],
      notification: NotificationBody.fromJson(json['notification']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'notification': notification.toJson(),
    };
  }
}

class NotificationBody {
  final String title;
  final String body;

  NotificationBody({
    required this.title,
    required this.body,
  });

  factory NotificationBody.fromJson(Map<String, dynamic> json) {
    return NotificationBody(
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}