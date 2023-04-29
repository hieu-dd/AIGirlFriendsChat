import 'package:ai_girl_friends/ext/string_ext.dart';
import 'package:ai_girl_friends/provider/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/conversation/model/message.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const direction = 'chat';
  static const argConversationId = 'conversationId';
  final int conversationId;

  ChatScreen({required this.conversationId});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  String _messageText = "";
  final messageController = TextEditingController();

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
    final conversation = ref.watch(conversationProvider).conversation;
    final partner = conversation?.participants
        .firstWhere((participant) => !participant.isMe);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: const Icon(Icons.chevron_left),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              color: Theme.of(context).colorScheme.onBackground,
              thickness: 1,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          title: partner != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 43,
                      height: 43,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(43),
                            border: Border.all(width: 2, color: Colors.blue)),
                        child: ClipOval(
                          child: Image.asset(
                            partner.largeBodyBlurCutOff,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      partner.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : null,
        ),
        body: conversation != null
            ? Column(
                children: [
                  Expanded(
                    child: MessageList(conversation.messages),
                  ),
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    padding: const EdgeInsets.only(left: 20, right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.onBackground)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          key: ValueKey("ChatTextField"),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          controller: messageController,
                          onChanged: (text) {
                            setState(() {
                              _messageText = text;
                            });
                          },
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: _messageText.isBlank()
                                ? Colors.grey
                                : Theme.of(context).colorScheme.onBackground,
                            child: InkWell(
                              onTap: _messageText.isBlank()
                                  ? null
                                  : () {
                                      ref
                                          .read(conversationProvider)
                                          .sendMessage(messageController.text);
                                      messageController.clear();
                                    },
                              child: Icon(
                                Icons.send,
                                size: 20,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ),
                        )
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

class MessageList extends StatelessWidget {
  final List<Message> messages;

  MessageList(this.messages);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: ListView.builder(
        reverse: true,
        itemBuilder: (context, index) {
          final length = messages.length;
          final message = messages[index];
          final isContinuous =
              ((index == 0 && length > 1) || (index < messages.length - 1)) &&
                  (messages[index].isContinuousMessage(messages[index + 1]));
          return Column(
            children: [
              if (!isContinuous) _buildMessageHeader(message),
              _buildChatMessage(message, context),
            ],
          );
        },
        itemCount: messages.length,
      ),
    );
  }

  Widget _buildMessageHeader(Message message) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(message.humanReadableTime()));
  }

  Widget _buildChatMessage(Message message, BuildContext context) {
    final isMe = message.sender.isMe;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            SizedBox(
              width: 40,
              height: 40,
              child: ClipOval(
                child: Image.asset(
                  message.sender.largeBodyBlurCutOff,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Flexible(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isMe ? Colors.grey : Color(message.sender.mainColor),
                ),
                margin: EdgeInsets.only(
                    left: isMe ? 100 : 10, right: isMe ? 0 : 100),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  message.message,
                  maxLines: 100,
                )),
          ),
        ],
      ),
    );
  }
}
