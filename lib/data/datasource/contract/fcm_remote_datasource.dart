import 'package:talk_me/data/models/notification_dto.dart';
import 'package:talk_me/data/network/results.dart';


abstract class FCMRemoteDatasource{

  Future<Results<bool>> sendNotification(NotificationDto notification);

}