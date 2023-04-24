import 'package:ai_girl_friends/provider/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final int conversationId;

  ChatScreen({required this.conversationId});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(conversationProvider).getLocalConversation(widget.conversationId);
  }

  @override
  Widget build(BuildContext context) {
    final conversation = ref.watch(conversationProvider).conversation;
    return Scaffold(
      body: conversation != null
          ? Column(
              children: [
                ...conversation.messages.map((e) => Text(e.message)).toList(),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: () {
                      ref.read(conversationProvider).sendMessage(Uuid().v4());
                    },
                    child: Text("Add message"))
              ],
            )
          : const Center(
              child: Text("Error"),
            ),
    );
  }
}
