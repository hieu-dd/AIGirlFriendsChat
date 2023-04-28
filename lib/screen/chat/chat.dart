import 'package:ai_girl_friends/provider/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const direction = 'chat';
  static const argConversationId = 'conversationId';
  final int conversationId;

  ChatScreen({required this.conversationId});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(), () {
      ref
          .read(conversationProvider)
          .getLocalConversation(widget.conversationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    final conversation = ref.watch(conversationProvider).conversation;
    return Scaffold(
      body: SafeArea(
        child: conversation != null
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: conversation.messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Text(conversation.messages[index].message);
                        }),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                    width: 400,
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(conversationProvider)
                                  .sendMessage(messageController.text);
                            },
                            child: Text("send")),
                        Expanded(
                            child: TextField(
                          controller: messageController,
                        )),
                      ],
                    ),
                  )
                ],
              )
            : const Center(
                child: Text("Error"),
              ),
      ),
    );
  }
}
