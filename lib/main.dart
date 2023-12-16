import 'package:chatheeps/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'screens/chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final channel;

  // Constructor to initialize the WebSocket channel
  MyApp() : channel = _initializeWebSocketChannel();

  // Helper method to establish a WebSocket connection
  static IOWebSocketChannel _initializeWebSocketChannel() {
    try {
      // Attempt to establish a connection
      return IOWebSocketChannel.connect(SOCKET_URL);
    } catch (e) {
      // Handle the exception
      print('Error connecting to WebSocket: $e');
      // You might want to return a fallback channel or throw an error here
      throw Exception('Failed to establish WebSocket connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Chat App'),
        ),
        body: ChatScreen(channel: channel),
      ),
    );
  }
}
