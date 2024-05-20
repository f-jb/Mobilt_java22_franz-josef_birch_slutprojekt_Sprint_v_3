
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'chat_repository.dart';

class ChatWidget extends StatefulWidget {

  const ChatWidget({super.key,});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _messageController = TextEditingController();
  final ChatClient chatClient = ChatClient(FirebaseDatabase.instance);

  // general layout of the chat widget. listview with the messages and then a
  // textinput to write messages in and a send button.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
           child: StreamBuilder<List<Map<String,dynamic>>>(
            stream:
                chatClient.getMessages(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message['user'] + " : " +message['message']),
                    );
                  },
                );


              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(hintText: 'Enter message'),
              ),
            ),
            IconButton(
              onPressed: () {
                final message = _messageController.text;
                if (message.isNotEmpty) {
                  chatClient.sendMessage(message);
                  _messageController.clear();
                }
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}