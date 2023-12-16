import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final WebSocketChannel channel;

  ChatScreen({required this.channel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();

    // Listen for incoming messages
    widget.channel.stream.listen((message) {
      setState(() {
        messages.add(message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //shows messages from the sockets
          ///the userId goes into the currentuserId to differenciate the user text
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isCurrentUser = message.startsWith('currentUserId'); // Replace 'currentUserId' with the actual ID of the current user
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                    left: isCurrentUser ? 50.0 : 10.0,
                    right: isCurrentUser ? 10.0 : 50.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isCurrentUser ? Colors.blueAccent : Colors.grey,
                  ),
                  child: ListTile(
                    title: Text(message),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue), // Add border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration:const InputDecoration(
                        labelText: 'Send a message',
                        border:
                            InputBorder.none, // Remove TextField default border
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      widget.channel.sink.add(_controller.text);
                      _controller.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Icon(Icons.send), // Use an icon for the send button
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Close the WebSocket connection when the widget is disposed
    widget.channel.sink.close();
    super.dispose();
  }
}
