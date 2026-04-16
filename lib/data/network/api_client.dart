
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:talk_me/data/models/notification_dto.dart';


part 'api_client.g.dart';

@singleton
@RestApi()
abstract class ApiClient {

  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;
  
  @POST("/v1/projects/{projectId}/messages:send")
  Future<bool> sendNotification(@Path("projectId") String projectId, @Body() NotificationDto notification, @Header("Authorization") String authToken);
}