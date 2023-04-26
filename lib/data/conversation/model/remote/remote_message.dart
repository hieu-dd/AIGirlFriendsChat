class RemoteMessage {
  final String role;
  final String content;

  RemoteMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'role': role,
        'content': content,
      };

  factory RemoteMessage.fromJson(Map<String, dynamic> json) => RemoteMessage(
        role: json['role'],
        content: json['content'],
      );
}
