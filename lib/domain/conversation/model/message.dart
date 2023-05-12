import 'package:ai_girl_friends/domain/user/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  int? id;
  int conversationId;
  late User sender;
  final String message;
  MessageStatus status;
  late int createdAt;
  late int updatedAt;

  Message({
    this.id,
    required this.conversationId,
    required this.message,
    required this.sender,
    required this.status,
  }) {
    createdAt = DateTime.now().microsecondsSinceEpoch;
    updatedAt = DateTime.now().microsecondsSinceEpoch;
  }

  String humanReadableTime() {
    final now = DateTime.now();
    final date = DateTime.fromMicrosecondsSinceEpoch(createdAt);
    final different = now.difference(date).inDays;

    if (different == 0) {
      return DateFormat("HH:mm").format(date);
    } else if (different < 31) {
      return DateFormat("MMMM dd").format(date);
    } else {
      return DateFormat("MMMM yyyy").format(date);
    }
  }

  bool isContinuousMessage(Message message) {
    final now = DateTime.now();
    final createTime = DateTime.fromMicrosecondsSinceEpoch(createdAt);
    final otherTime = DateTime.fromMicrosecondsSinceEpoch(message.createdAt);
    final differentNow = now.difference(createTime).inDays;
    final differentMessage = createTime.difference(otherTime).inDays;
    if (differentNow == 0 && differentMessage == 0) {
      return createdAt - message.createdAt <
          const Duration(minutes: 4).inMicroseconds;
    } else if (createTime.month == otherTime.month &&
        createTime.year == otherTime.year) {
      return createTime.day == otherTime.day;
    } else {
      return false;
    }
  }

  @override
  List<Object?> get props => [
        id,
        conversationId,
        sender,
        message,
        createdAt,
        updatedAt,
      ];
}

enum MessageStatus {
  sent,
  sending,
  fail,
  typing,
}
