class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.openai.com/";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 30);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 30);

  static const String chat = '/v1/chat/completions';
}
