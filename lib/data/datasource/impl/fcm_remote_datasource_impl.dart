import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_me/data/datasource/contract/fcm_remote_datasource.dart';
import 'package:talk_me/data/models/notification_dto.dart';
import 'package:talk_me/data/network/api_client.dart';
import 'package:talk_me/data/network/results.dart';
import 'package:talk_me/data/network/safeCall.dart';


@Injectable(as: FCMRemoteDatasource)
class FCMRemoteDatasourceImpl implements FCMRemoteDatasource{

  FCMRemoteDatasourceImpl(this._apiClient);
  final ApiClient _apiClient;

  @override
  Future<Results<bool>> sendNotification(NotificationDto notification) {
    return safeCall(()async{
      final credentials = await _getAccessToken();
      final accessToken = credentials.accessToken.data;
      final projectId = dotenv.env['PROJECT_ID'];
      var response = await _apiClient.sendNotification(projectId!, notification, "Bearer $accessToken");
      return Success(data: response);
    });
  }

  Future<AccessCredentials> _getAccessToken() async  {
    final serviceAccountPath = dotenv.env['SECRET_PATH'];

    String serviceAccountJson = await rootBundle.loadString(
      serviceAccountPath!,
    );

    // log("json: $serviceAccountJson");
    final serviceAccount = ServiceAccountCredentials.fromJson(
      serviceAccountJson,
    );

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(serviceAccount, scopes);
    return client.credentials;
  }
}