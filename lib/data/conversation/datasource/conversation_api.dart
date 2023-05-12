import 'package:ai_girl_friends/common/remote/dio_client.dart';
import 'package:ai_girl_friends/common/remote/end_points.dart';
import 'package:ai_girl_friends/data/conversation/model/remote/remote_message.dart';
import 'package:ai_girl_friends/data/conversation/model/remote/send_turbo_messages.dart';
import 'package:dio/dio.dart';

class ConversationApi {
  final DioClient dioClient;

  ConversationApi(this.dioClient);

  Future<RemoteMessage> sendMessage(
    SendTurboMessagesRequest request,
  ) async {
    final data = request.toJson();
    final response = (await dioClient.post(
      Endpoints.chat,
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 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",
      }),
    ))
        .data;
    return RemoteMessage(
        role: response['choices'][0]['message']['role'],
        content: response['choices'][0]['message']['content']);
  }
}
