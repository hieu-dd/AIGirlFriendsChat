import 'package:ai_girl_friends/data/conversation/model/remote/remote_message.dart';

class SendTurboMessagesRequest {
  String model;
  List<RemoteMessage> messages;

  SendTurboMessagesRequest({
    this.model = 'gpt-3.5-turbo',
    this.messages = const [],
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'model': model,
        'messages': messages.map((e) => e.toJson())
      };
}
