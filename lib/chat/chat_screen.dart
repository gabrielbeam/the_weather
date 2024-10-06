import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather/common/custom_app_bar.dart';
import 'package:the_weather/config.dart';
import 'package:the_weather/packages/bottom_navigator.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends ConsumerState<ChatScreen> {
  final _openAI = OpenAI.instance.build(
      token: Config.openApiKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 120),
      ));

  final appUser = ChatUser(
    id: "1",
    firstName: "Adam",
    lastName: "Ondra",
  );
  final ai = ChatUser(id: "2", firstName: "Tomoa", lastName: "Narasaki");

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text: "Hello, I'm Tomoa. How can I help you?",
      user: ai,
      createdAt: DateTime.now(),
    ));
  }

  _sendMessageFromAI(String text) {
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          createdAt: DateTime.now(),
          text: text,
          user: ai,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Chat"),
      body: DashChat(
        currentUser: appUser,
        typingUsers: _typingUsers,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Colors.blueGrey,
          textColor: Colors.white,
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Future<void> getChatResponse(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
      _typingUsers.add(ai);
    });
    List<Map<String, dynamic>> messagesHistory = _messages.reversed.map((m) {
      if (m.user == appUser) {
        return {
          'role': 'user',
          'content': m.text,
        };
      } else {
        return {
          'role': 'assistant',
          'content': m.text,
        };
      }
    }).toList();

    final request = ChatCompleteText(
        model: ChatModelFromValue(model: 'chatgpt-4o-latest'), messages: messagesHistory, maxToken: 200);
    await _openAI.onChatCompletion(request: request).then((response) {
      for (var message in response!.choices) {
        if (message.message != null) {
          _sendMessageFromAI(message.message!.content);
        }
      }
    }).catchError((error) {
      _sendMessageFromAI('Sorry, something went wrong. Error: $error');
    }).whenComplete(() {
      setState(() {
        _typingUsers.remove(ai);
      });
    });
  }
}
